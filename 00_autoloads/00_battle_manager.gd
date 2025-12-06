extends Node

var current_demon: Demon
var demon_hp: int
var demon_seduction: int

enum STATES {
	NOT_IN_BATTLE,
	AWAITING_TURN_CHOICE,
	EXECUTING_TURNS,
	BATTLE_OVER,
}

var battle_state: STATES
var turn_queue: Array = []

func _ready() -> void:
	battle_state = STATES.NOT_IN_BATTLE
	Signals.battle_turns_started.connect(execute_turn)

func initiate_fight() -> void:
	_set_up_demon()
	battle_state = STATES.AWAITING_TURN_CHOICE
	DialogPanel.push_text(current_demon.entry_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_turns_finished.emit()

func execute_turn() -> void:
	battle_state = STATES.EXECUTING_TURNS
	var battle_over = false
	for turn in turn_queue:
		if turn is Item:
			turn.effect.trigger()
		elif turn is Dialog:
			DialogPanel.push_text("You: "+turn.dialog_text)
			demon_hp -= turn.damage
			demon_seduction += turn.seduction
			if turn.type == Dialog.DIALOG_TYPE.ATTACK:
				AudioManager.play_sfx("hit")
			else:
				AudioManager.play_sfx("seduce")
		await Signals.dialog_finished
		turn_queue.pop_at(0)
		# hp/seduction checks in to battleover state
		if PlayerManager.hp <= 0:
			_player_lost()
			battle_over = true
			break
		elif demon_hp <= 0:
			_demon_beaten()
			battle_over = true
			break
		elif demon_seduction >= current_demon.seduction_target:
			_demon_seduced()
			battle_over = true
			break
	if battle_over:
		_end_battle()
	else:
		_finish_turn()

func _finish_turn() -> void:
	battle_state = STATES.AWAITING_TURN_CHOICE
	Signals.battle_turns_finished.emit()
	Signals.battle_options_refreshed.emit()

func _set_up_demon() -> void:
	demon_hp = current_demon.hp
	demon_seduction = 0

func _player_lost() -> void:
	DialogPanel.push_text(current_demon.lose_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_player_lost.emit()

func _demon_beaten() -> void:
	DialogPanel.push_text(current_demon.beaten_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_demon_beaten.emit()

func _demon_seduced() -> void:
	DialogPanel.push_text(current_demon.seduced_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_demon_seduced.emit()

func _end_battle() -> void:
	if DialogPanel.dialog_visible:
		await Signals.dialog_finished
	Signals.battle_end.emit()
	battle_state = STATES.BATTLE_OVER

func leave_battle() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	Signals.battle_left.emit()
	battle_state = STATES.NOT_IN_BATTLE

func get_dialog_options() -> Array:
	var results: Array = []

	# Pools
	var insult_pool = PlayerManager.insult_dialog_pool
	var seduction_pool = PlayerManager.seduction_dialog_pool

	# Seduction influence (0–1)
	var base_seduction := float(demon_seduction) / float(max(demon_hp, 1))

	# Ensure seduction is ALWAYS at least 10% likely
	var seduction_weight: float = clamp(base_seduction, 0.05, 0.9)

	for i in range(4):
		var selected_dialog = null
		var pool
		for attempt in range(10):  # try multiple times to find a unique one
			var choose_seduction: bool = randf() < seduction_weight
			pool = seduction_pool if choose_seduction else insult_pool
			if pool.is_empty():
				pool = insult_pool if choose_seduction else seduction_pool

			var candidate = _choose_weighted_dialog(pool)

			if candidate not in results:
				selected_dialog = candidate
				break
		
		# If after 10 tries it's still not unique, force a fallback unique pick
		if selected_dialog == null:
			selected_dialog = _pick_any_unique(pool, results)

		results.append(selected_dialog)

	return results


func _choose_weighted_dialog(pool: Array) -> Dialog:
	var weighted: Array = []

	for dialog in pool:
		var weight := 1

		match dialog.rarity:
			dialog.DIALOG_RARITY.COMMON:
				weight = 7
			dialog.DIALOG_RARITY.RARE:
				weight = 2
			dialog.DIALOG_RARITY.ULTRA_RARE:
				weight = 1

		# Duplicate the dialog "weight" times
		for i in range(weight):
			weighted.append(dialog)

	return weighted[randi() % weighted.size()]

func _pick_any_unique(pool: Array, existing: Array) -> Dialog:
	for dialog in pool:
		if dialog not in existing:
			return dialog
	# If pool is too small, return ANY dialog (shows a warning condition)
	return pool[0]

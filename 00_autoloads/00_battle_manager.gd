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
var player_turn

var consumed_items: Array[Item] = []

func _ready() -> void:
	battle_state = STATES.NOT_IN_BATTLE
	Signals.battle_turns_started.connect(execute_turn)

func initiate_fight() -> void:
	_set_up_demon()
	consumed_items = []
	battle_state = STATES.AWAITING_TURN_CHOICE
	DialogPanel.push_text(current_demon.entry_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_turns_finished.emit()

func execute_turn() -> void:
	battle_state = STATES.EXECUTING_TURNS
	var demon_turn = _get_demon_turn(current_demon)
	
	# Player turn
	if player_turn is Item:
		player_turn.effect.trigger()
		consumed_items.append(player_turn)
		PlayerManager.consume_item(player_turn)
	elif player_turn is Dialog:
		_attack_with_dialog(player_turn)
		Signals.damage_dealt.emit()
	await Signals.dialog_finished
	
	Signals.battle_single_turn.emit()
	
	# Partner interjection
	await _random_partner_attacks()
	
	# Battle end checks?
	if demon_hp <= 0:
		_demon_beaten()
		return
	elif demon_seduction >= current_demon.seduction_target:
		_demon_seduced()
		return
		
	# Demon turn
	DialogPanel.push_text(demon_turn.dialog_text, current_demon)
	PlayerManager.hp -= demon_turn.damage
	Signals.damage_dealt.emit()
	await Signals.dialog_finished
	
	Signals.battle_single_turn.emit()
	
	# Battle end check?
	if PlayerManager.hp <= 0:
		_player_lost()
		return
		
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
	_end_battle()

func _demon_beaten() -> void:
	PlayerManager.loot_demon(current_demon)
	DialogPanel.push_text(current_demon.beaten_text, current_demon)
	await Signals.dialog_finished
	PlayerManager.return_consumed_items(consumed_items)
	Signals.battle_demon_beaten.emit()
	_end_battle()

func _demon_seduced() -> void:
	DialogPanel.push_text(current_demon.seduced_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_demon_seduced.emit()
	_end_battle()

func _end_battle() -> void:
	Signals.battle_end.emit()
	battle_state = STATES.BATTLE_OVER

func leave_battle() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	SaveManager.save_game()
	Signals.battle_left.emit()
	battle_state = STATES.NOT_IN_BATTLE

func get_dialog_options() -> Array[Dialog]:
	var results: Array[Dialog] = []

	# Pools
	var insult_pool = PlayerManager.insult_dialog_pool
	var seduction_pool = PlayerManager.seduction_dialog_pool

	# Seduction influence (0–1)
	var base_seduction := float(demon_seduction) / float(current_demon.seduction_target)

	# Ensure seduction is ALWAYS at least 15% likely and at most 70%
	var seduction_weight: float = clamp(base_seduction, 0.15, 0.7)

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

# what to scale the damage by when progressing the game
# only scale the player's dialog to make the gained skills stronger
func _difficulity_scaling(dialog: Dialog) -> float:
	if dialog.resource_path.split("/")[-2] != "player":
		return 0.7

	var defeated_demons = GameStateManager.demon_states.values().filter(func(v): return v != GameStateManager.DEMON_STATES.AVAILABLE).size()

	return [
		1.0,
		0.8,
		0.6,
		0.5,
		0.4,
		0.3,
		0.2,
		0.0, # Should never happen
	][defeated_demons]

func _attack_with_dialog(dialog: Dialog, demon: Demon = null) -> void:
	var text: String = dialog.dialog_text if demon else "You: "+dialog.dialog_text
	DialogPanel.push_text(text, demon)
	demon_hp -= int(dialog.damage * _difficulity_scaling(dialog))
	demon_seduction += int(dialog.seduction * _difficulity_scaling(dialog))
	if dialog.type == Dialog.DIALOG_TYPE.ATTACK:
		AudioManager.play_sfx("hit")
	else:
		AudioManager.play_sfx("seduce")

func _random_partner_attacks() -> void:
	for demon in GameStateManager.seduced_demons:
		if randi() % 100 < 25:
			var demon_turn = _get_demon_turn(demon)
			_attack_with_dialog(demon_turn, demon)
			Signals.damage_dealt.emit()
			await Signals.dialog_finished
			Signals.battle_single_turn.emit()

func _get_demon_turn(demon: Demon) -> Dialog:
	var seduction_weight := (float(demon_seduction) / float(current_demon.seduction_target)) * 100
	var capped_weight = clamp(seduction_weight, 5, 70)
	if randi() % 100 < capped_weight:
		return demon.battle_seduce_dialog.pick_random()
	else:
		return demon.battle_insult_dialog.pick_random()

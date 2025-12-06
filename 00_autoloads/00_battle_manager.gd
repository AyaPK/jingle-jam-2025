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
	DialogPanel.push_text(current_demon.entry_text)
	await Signals.dialog_finished
	Signals.battle_turns_finished.emit()

func execute_turn() -> void:
	battle_state = STATES.EXECUTING_TURNS
	var battle_over = false
	for turn in turn_queue:
		if turn is Item:
			turn.effect.trigger()
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

func _set_up_demon() -> void:
	demon_hp = current_demon.hp
	demon_seduction = 0

func _player_lost() -> void:
	DialogPanel.push_text(current_demon.lose_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_player_lost.emit()

func _demon_beaten() -> void:
	# TODO: Demon beaten text
	await Signals.dialog_finished
	Signals.battle_demon_beaten.emit()

func _demon_seduced() -> void:
	DialogPanel.push_text(current_demon.seduced_text, current_demon)
	await Signals.dialog_finished
	Signals.battle_demon_seduced.emit()

func _end_battle() -> void:
	battle_state = STATES.BATTLE_OVER

func leave_battle() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	Signals.battle_left.emit()
	battle_state = STATES.NOT_IN_BATTLE

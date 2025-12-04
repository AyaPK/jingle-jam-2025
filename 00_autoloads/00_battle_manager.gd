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
	for turn in turn_queue:
		if turn is Item:
			turn.effect.trigger()
		await Signals.dialog_finished
		turn_queue.pop_at(0)
	finish_turn()

func finish_turn() -> void:
	# hp/seduction checks in to battleover state
	battle_state = STATES.AWAITING_TURN_CHOICE
	Signals.battle_turns_finished.emit()
	print("End of turn state: HP = "+str(demon_hp)+"  -  Seduction = "+str(demon_seduction))

func _set_up_demon() -> void:
	demon_hp = current_demon.hp
	demon_seduction = 0

func leave_battle() -> void:
	battle_state = STATES.NOT_IN_BATTLE

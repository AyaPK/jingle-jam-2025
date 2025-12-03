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

func initiate_fight() -> void:
	_set_up_demon()
	battle_state = STATES.AWAITING_TURN_CHOICE
	DialogPanel.push_text(current_demon.entry_text)

func execute_turn() -> void:
	battle_state = STATES.EXECUTING_TURNS
	for turn in turn_queue:
		if turn is Item:
			turn.effect.trigger()
	finish_turn()

func finish_turn() -> void:
	# hp/seduction checks in to battleover state
	battle_state = STATES.AWAITING_TURN_CHOICE

func _set_up_demon() -> void:
	demon_hp = current_demon.hp
	demon_seduction = 0

func leave_battle() -> void:
	battle_state = STATES.NOT_IN_BATTLE

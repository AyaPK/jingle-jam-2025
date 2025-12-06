extends Node

var has_any_partners: bool :
	get: return DEMON_STATES.SEDUCED in demon_states.values()

var has_pending_demons: bool :
	get: return DEMON_STATES.AVAILABLE in demon_states.values()

enum DEMON_STATES {
	AVAILABLE,
	BEATEN,
	SEDUCED,
}

var demon_states: Dictionary = {
	"Wrath": DEMON_STATES.AVAILABLE,
	"Lust": DEMON_STATES.AVAILABLE,
	"Greed": DEMON_STATES.AVAILABLE,
	"Gluttony": DEMON_STATES.AVAILABLE,
	"Pride": DEMON_STATES.AVAILABLE,
	"Sloth": DEMON_STATES.AVAILABLE,
	"Envy": DEMON_STATES.AVAILABLE
}

func _ready() -> void:
	Signals.battle_demon_beaten.connect(beat_demon)
	Signals.battle_demon_seduced.connect(seduce_demon)
	Signals.battle_left.connect(process_battle_left)

func beat_demon() -> void:
	var demon = BattleManager.current_demon
	demon_states[demon.internal_name] = DEMON_STATES.BEATEN

func seduce_demon() -> void:
	var demon = BattleManager.current_demon
	demon_states[demon.internal_name] = DEMON_STATES.SEDUCED

func demon_is_seduced(demon_name) -> bool:
	return demon_states[demon_name] == DEMON_STATES.SEDUCED

func demon_is_beaten(demon_name) -> bool:
	return demon_states[demon_name] == DEMON_STATES.BEATEN

func process_battle_left() -> void:
	if !has_pending_demons:
		# TODO: Process game end
		print("END OF GAME!!!!")
		get_tree().quit()

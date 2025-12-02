extends Node

enum DEMON_STATES {
	AVAILABLE,
	BEATEN,
	SEDUCED,
}

var demon_states: Dictionary = {
	"wrath": DEMON_STATES.AVAILABLE,
	"lust": DEMON_STATES.AVAILABLE,
	"greed": DEMON_STATES.AVAILABLE,
	"gluttony": DEMON_STATES.AVAILABLE,
	"pride": DEMON_STATES.AVAILABLE,
	"sloth": DEMON_STATES.AVAILABLE,
	"envy": DEMON_STATES.AVAILABLE
}

var is_in_battle: bool = false

func beat_demon(demon_name: String) -> void:
	demon_states[demon_name] = DEMON_STATES.BEATEN

func seduce_demon(demon_name: String) -> void:
	demon_states[demon_name] = DEMON_STATES.SEDUCED

func lose_demon(demon_name: String) -> void:
	demon_states[demon_name] = DEMON_STATES.AVAILABLE

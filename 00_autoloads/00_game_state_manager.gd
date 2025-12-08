extends Node

const ENVY = preload("res://resources/demons/envy.tres")
const GLUTTONY = preload("res://resources/demons/gluttony.tres")
const GREED = preload("res://resources/demons/greed.tres")
const LUST = preload("res://resources/demons/lust.tres")
const PRIDE = preload("res://resources/demons/pride.tres")
const SLOTH = preload("res://resources/demons/sloth.tres")
const WRATH = preload("res://resources/demons/wrath.tres")

var all_demons: Array[Demon] = [ENVY, GLUTTONY, GREED, LUST, PRIDE, SLOTH, WRATH]

var has_any_partners: bool :
	get: return DEMON_STATES.SEDUCED in demon_states.values()

var has_available_demons: bool :
	get: return DEMON_STATES.AVAILABLE in demon_states.values()

var seduced_demons: Array[Demon]:
	get: return all_demons.filter(demon_is_seduced)

enum DEMON_STATES {
	AVAILABLE,
	BEATEN,
	SEDUCED,
}

var demon_states: Dictionary = {
	ENVY.internal_name: DEMON_STATES.AVAILABLE,
	GLUTTONY.internal_name: DEMON_STATES.AVAILABLE,
	GREED.internal_name: DEMON_STATES.AVAILABLE,
	LUST.internal_name: DEMON_STATES.AVAILABLE,
	PRIDE.internal_name: DEMON_STATES.AVAILABLE,
	SLOTH.internal_name: DEMON_STATES.AVAILABLE,
	WRATH.internal_name: DEMON_STATES.AVAILABLE
}

func _ready() -> void:
	Signals.battle_demon_beaten.connect(beat_demon)
	Signals.battle_demon_seduced.connect(seduce_demon)
	Signals.battle_left.connect(process_battle_left)

func refresh() -> void:
	demon_states = {
		ENVY.internal_name: DEMON_STATES.AVAILABLE,
		GLUTTONY.internal_name: DEMON_STATES.AVAILABLE,
		GREED.internal_name: DEMON_STATES.AVAILABLE,
		LUST.internal_name: DEMON_STATES.AVAILABLE,
		PRIDE.internal_name: DEMON_STATES.AVAILABLE,
		SLOTH.internal_name: DEMON_STATES.AVAILABLE,
		WRATH.internal_name: DEMON_STATES.AVAILABLE
	}

func beat_demon() -> void:
	var demon = BattleManager.current_demon
	demon_states[demon.internal_name] = DEMON_STATES.BEATEN

func seduce_demon() -> void:
	var demon = BattleManager.current_demon
	demon_states[demon.internal_name] = DEMON_STATES.SEDUCED

func demon_is_seduced(demon: Demon) -> bool:
	return demon_states[demon.internal_name] == DEMON_STATES.SEDUCED

func demon_is_beaten(demon: Demon) -> bool:
	return demon_states[demon.internal_name] == DEMON_STATES.BEATEN

func process_battle_left() -> void:
	if !has_available_demons:
		get_tree().change_scene_to_file("res://scenes/credits.tscn")

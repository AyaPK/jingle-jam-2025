class_name Battle extends Node2D

enum MenuState {
	HOME,
	FIGHT,
	ITEM,
	FLIRT,
	PARTNER,
}

var menu_state = MenuState.HOME;

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()

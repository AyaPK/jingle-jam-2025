extends Node2D

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()

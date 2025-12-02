extends Node2D

func _ready() -> void:
	for item in PlayerManager.inventory:
		print(item.item_name)

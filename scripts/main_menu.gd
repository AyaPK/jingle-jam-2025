extends Node2D
@onready var button: Button = $CanvasLayer/HFlowContainer/Button

func _ready() -> void:
	for item in PlayerManager.inventory:
		print(item.item_name)
	button.grab_focus()

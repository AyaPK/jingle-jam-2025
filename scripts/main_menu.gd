extends Node2D
@onready var button: Button = $CanvasLayer/HFlowContainer/WrathButton
@onready var partners_button: Button = $CanvasLayer/HBoxContainer/PartnersButton

func _ready() -> void:
	for item in PlayerManager.inventory:
		print(item.item_name)
	button.grab_focus()
	
	if !GameStateManager.has_any_partners:
		partners_button.hide()

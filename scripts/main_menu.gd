extends Node2D
@onready var button: Button = $CanvasLayer/HFlowContainer/WrathButton
@onready var partners_button: Button = $CanvasLayer/HBoxContainer/PartnersButton

func _ready() -> void:
	for item in PlayerManager.inventory:
		print(item.item_name)
	button.grab_focus()
	
	if !GameStateManager.has_any_partners:
		partners_button.hide()

func _process(_delta: float) -> void:
	pass
	
	### Uncomment to test things
	#if Input.is_action_just_pressed("test"):
		#DialogPanel.push_text(random_string(100))
		#print("Pushed a random string to the dialog system")

func random_string(length: int = 10) -> String:
	var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var result = ""
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in length:
		result += chars[rng.randi_range(0, chars.length() - 1)]
	return result

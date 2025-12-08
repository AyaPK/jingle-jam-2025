extends Node2D
@onready var button: Button = $CanvasLayer/HFlowContainer/WrathButton

func _ready() -> void:
	if not PreludeManager.prelude_shown:
		get_tree().change_scene_to_file("res://scenes/prelude.tscn")
	button.grab_focus()
	AudioManager.play_music("menu")

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

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Skills.tscn")

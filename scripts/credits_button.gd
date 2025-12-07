extends Button

func _on_pressed():
	AudioManager.play_sfx("press_button")
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

func _on_mouse_entered() -> void:
	grab_focus()
	AudioManager.play_sfx("hover_button")

func _on_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

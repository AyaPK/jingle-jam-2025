extends Node2D

@onready var main_menu_button := $CanvasLayer/MainMenuButton

func _ready() -> void:
	AudioManager.play_music("menu")

func _on_main_menu_button_pressed():
	AudioManager.play_sfx("press_button")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.grab_focus()
	AudioManager.play_sfx("hover_button")

func _on_main_menu_button_mouse_exited() -> void:
	main_menu_button.release_focus()

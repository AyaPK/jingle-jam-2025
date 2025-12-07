extends Node2D

@onready var main_menu_button := $CanvasLayer/MainMenuButton
@onready var are_you_sure_panel: PanelContainer = $CanvasLayer/AreYouSurePanel

func _ready() -> void:
	AudioManager.play_music("menu")
	are_you_sure_panel.hide()

func _on_main_menu_button_pressed():
	AudioManager.play_sfx("press_button")
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.grab_focus()
	AudioManager.play_sfx("hover_button")

func _on_main_menu_button_mouse_exited() -> void:
	main_menu_button.release_focus()

func _on_delete_save_mouse_entered() -> void:
	%DeleteSave.grab_focus()

func _on_delete_save_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

func _on_delete_save_pressed() -> void:
	are_you_sure_panel.show()
	$%RejectButton.grab_focus()

func _on_confirm_button_pressed() -> void:
	SaveManager.delete_data()

func _on_reject_button_pressed() -> void:
	are_you_sure_panel.hide()

func _on_confirm_button_mouse_entered() -> void:
	%ConfirmButton.grab_focus()

func _on_reject_button_mouse_entered() -> void:
	%RejectButton.grab_focus()


func _on_confirm_button_focus_entered() -> void:
	pass # Replace with function body.


func _on_reject_button_focus_entered() -> void:
	pass # Replace with function body.

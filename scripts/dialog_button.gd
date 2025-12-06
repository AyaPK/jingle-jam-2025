class_name DialogButton extends Button

var dialog_resource: Dialog

func _on_pressed() -> void:
	BattleManager.turn_queue.append(dialog_resource)
	Signals.battle_turns_started.emit()
	AudioManager.play_sfx("press_button")

func _on_mouse_entered() -> void:
	grab_focus()
	AudioManager.play_sfx("hover_button")

func set_up_details() -> void:
	if dialog_resource:
		text = dialog_resource.name

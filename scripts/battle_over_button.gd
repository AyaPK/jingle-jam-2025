class_name BattleOverButton extends Button

func _on_pressed():
	BattleManager.leave_battle()

func _on_mouse_entered() -> void:
	grab_focus()

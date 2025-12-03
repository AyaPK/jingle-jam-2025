class_name MyMenuButton extends Button

@export var next_menu: Battle.MenuState


func _on_pressed():
	var old_state = get_tree().current_scene.menu_state

	get_tree().current_scene.menu_state = next_menu
	
	Signals.menu_state_changed.emit(old_state, next_menu)

@tool
class_name MenuGroup extends Container

@export var show_in_menu_state: Battle.MenuState

func _ready():
	if Engine.is_editor_hint():
		return
	_refresh_visibility(Battle.MenuState.HOME)
	Signals.menu_state_changed.connect(_on_menu_state_changed)

func _on_menu_state_changed(_previous_state: Battle.MenuState, next_state: Battle.MenuState):
	_refresh_visibility(next_state)
	
	print(next_state)

func _get_configuration_warnings() -> PackedStringArray:
	if !_check_for_child_button():
		return ["Requires at least one child button"]
	else:
		return []

func _check_for_child_button() -> bool:
	for c in get_children():
		if c is Button:
			return true
	return false

func _refresh_visibility(game_state: Battle.MenuState):
	if show_in_menu_state == game_state:
		show()
		get_children()[0].grab_focus()
	else:
		hide()

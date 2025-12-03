extends Container

@export var show_in_menu_state: Battle.MenuState

func _ready():
	_refresh_visibility(Battle.MenuState.HOME)
	Signals.menu_state_changed.connect(_on_menu_state_changed)

func _on_menu_state_changed(_previous_state: Battle.MenuState, next_state: Battle.MenuState):
	_refresh_visibility(next_state)
	
	print(next_state)

func _refresh_visibility(game_state: Battle.MenuState):
	if show_in_menu_state == game_state:
		show()
	else:
		hide()

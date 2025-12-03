extends Node

signal signal1
signal signal2

signal dialog_started
signal dialog_finished
signal dialog_line_started(text: String)

signal menu_state_changed(old_state: Battle.MenuState, new_state: Battle.MenuState)

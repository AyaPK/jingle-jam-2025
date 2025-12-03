class_name Battle extends Node2D

enum MenuState {
	HOME,
	FIGHT,
	ITEM,
	FLIRT,
	PARTNER,
}

var menu_state = MenuState.HOME;

@onready var main_buttons_container: HFlowContainer = $CanvasLayer/HomeMenu
@onready var fight: Button = $CanvasLayer/HomeMenu/Fight

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()
	
	main_buttons_container.hide()
	
	Signals.dialog_finished.connect(show_main_buttons)

func show_main_buttons() -> void:
	fight.grab_focus()
	main_buttons_container.show()

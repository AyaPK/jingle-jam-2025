class_name Battle extends Node2D

enum MenuState {
	HOME,
	FIGHT,
	ITEM,
	FLIRT,
	PARTNER,
	HIDDEN
}

var menu_state = MenuState.HOME;

@onready var main_buttons_container: CanvasLayer = $CanvasLayer/HomeMenu
@onready var fight: BattleMenuButton = $CanvasLayer/HomeMenu/HFlowContainer/Fight
@onready var battle_item_container: HFlowContainer = $CanvasLayer/ItemsMenu/PanelContainer/BattleItemContainer

const BATTLE_ITEM_BUTTON = preload("uid://u5t8wd0vwpvu")

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()
	main_buttons_container.hide()
	
	_load_item_buttons()
	
	Signals.dialog_finished.connect(show_main_buttons)
	Signals.dialog_started.connect(_hide_menu)

func show_main_buttons() -> void:
	fight.grab_focus()
	main_buttons_container.show()

func _load_item_buttons() -> void:
	for item in PlayerManager.inventory:
		var item_button: BattleItemButton = BATTLE_ITEM_BUTTON.instantiate()
		battle_item_container.add_child(item_button)
		item_button.item_resource = item
		item_button.load_item_details()
		battle_item_container.move_child(item_button, 0)

func _hide_menu() -> void:
	menu_state = MenuState.HIDDEN
	Signals.menu_state_changed.emit(MenuState.HOME, MenuState.HIDDEN)

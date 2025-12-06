class_name Battle extends Node2D

enum MenuState {
	HOME,
	FIGHT,
	ITEM,
	FLIRT,
	PARTNER,
	HIDDEN
}
\
var menu_state = MenuState.HOME;

@onready var main_buttons_container: CanvasLayer = $CanvasLayer/HomeMenu
@onready var fight: BattleMenuButton = $CanvasLayer/HomeMenu/HFlowContainer/Fight
@onready var battle_item_container: HFlowContainer = $CanvasLayer/ItemsMenu/PanelContainer/BattleItemContainer
@onready var battle_button_container: HFlowContainer = $CanvasLayer/FightMenu/BattleButtonContainer

const BATTLE_ITEM_BUTTON = preload("uid://u5t8wd0vwpvu")
const DIALOG_BUTTON = preload("uid://gb850wcuo607")

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()
	main_buttons_container.hide()
	
	_load_item_buttons()
	get_dialog_buttons()
	
	Signals.battle_turns_started.connect(_hide_menu)
	Signals.battle_turns_finished.connect(show_main_buttons)
	Signals.battle_options_refreshed.connect(get_dialog_buttons)

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

func get_dialog_buttons() -> void:
	BattleManager.get_dialog_options()
	for _c in battle_button_container.get_children():
		if _c is DialogButton:
			_c.queue_free()
			await _c.tree_exited
	for dialog_option in BattleManager.get_dialog_options():
		var dialog_button: DialogButton = DIALOG_BUTTON.instantiate()
		dialog_button.dialog_resource = dialog_option
		battle_button_container.add_child(dialog_button)
		battle_button_container.move_child(dialog_button, 0)
		dialog_button.set_up_details()
	pass

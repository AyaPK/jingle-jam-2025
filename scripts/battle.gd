class_name Battle extends Node2D

enum MenuState {
	HOME,
	FIGHT,
	ITEM,
	FLIRT,
	PARTNER,
	HIDDEN,
	BATTLE_OVER
}

var menu_state = MenuState.HOME;

@onready var main_buttons_container: CanvasLayer = $CanvasLayer/HomeMenu
@onready var fight: BattleMenuButton = $CanvasLayer/HomeMenu/HFlowContainer/Fight
@onready var battle_item_container: HFlowContainer = $CanvasLayer/ItemsMenu/PanelContainer/BattleItemContainer
@onready var battle_button_container: HFlowContainer = $CanvasLayer/FightMenu/BattleButtonContainer
@onready var battle_over_container: CanvasLayer = $CanvasLayer/BattleOverMenu
@onready var battle_over_lose_text: RichTextLabel = $CanvasLayer/BattleOverMenu/PanelContainer/YouLoseText
@onready var battle_over_win_text: RichTextLabel = $CanvasLayer/BattleOverMenu/PanelContainer/YouWinText
@onready var opponent_hp: TextureProgressBar = $CanvasLayer/OpponentHP
@onready var player_hp: TextureProgressBar = $CanvasLayer/PlayerHP
@onready var heart: AnimatedSprite2D = $CanvasLayer/Heart

const BATTLE_ITEM_BUTTON = preload("res://scenes/battle_item_button.tscn")
const DIALOG_BUTTON = preload("res://scenes/dialog_option.tscn")

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()
	main_buttons_container.hide()
	
	_load_item_buttons()
	get_dialog_buttons()
	update_ui()
	
	Signals.battle_turns_started.connect(_hide_menu)
	Signals.battle_turns_finished.connect(show_main_buttons)
	Signals.battle_options_refreshed.connect(get_dialog_buttons)
	Signals.battle_end.connect(battle_over)
	Signals.battle_player_lost.connect(set_player_lost)
	Signals.battle_demon_beaten.connect(set_demon_beaten)
	Signals.battle_demon_seduced.connect(set_demon_seduced)
	Signals.damage_dealt.connect(update_ui)
	Signals.battle_demon_seduction_dealt.connect(_on_seduction_dealt)
	
	AudioManager.play_music("battle")

func show_main_buttons() -> void:
	fight.grab_focus()
	main_buttons_container.show()
	_load_item_buttons()

func _on_seduction_dealt() -> void:
	heart.show()
	await get_tree().create_timer(2).timeout
	heart.hide()

func _load_item_buttons() -> void:
	for _c in battle_item_container.get_children():
		if _c is BattleItemButton:
			_c.queue_free()
			await _c.tree_exited
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

func battle_over() -> void:
	Signals.menu_state_changed.emit(menu_state, MenuState.BATTLE_OVER)

func set_player_lost() -> void:
	battle_over_win_text.hide()
	battle_over_lose_text.show()

func set_demon_beaten() -> void:
	battle_over_lose_text.hide()
	battle_over_win_text.text = "You have vanquished "+BattleManager.current_demon.demon_name+"!\n\nYou have learned valuable lessons here that may help you in future battles..."
	battle_over_win_text.show()

func set_demon_seduced() -> void:
	battle_over_lose_text.hide()
	battle_over_win_text.text = "You have seduced "+BattleManager.current_demon.demon_name+"!\n\nMaybe their companionship will prove useful..."
	battle_over_win_text.show()

func update_ui() -> void:
	opponent_hp.value = BattleManager.demon_hp
	player_hp.value = PlayerManager.hp

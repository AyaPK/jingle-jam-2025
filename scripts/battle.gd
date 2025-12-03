extends Node2D

@onready var main_buttons_container: HFlowContainer = $CanvasLayer/MainButtonsContainer
@onready var fight: Button = $CanvasLayer/MainButtonsContainer/Fight

func _ready() -> void:
	$CanvasLayer/Opponent.texture = BattleManager.current_demon.full_image
	BattleManager.initiate_fight()
	
	main_buttons_container.hide()
	
	Signals.dialog_finished.connect(show_main_buttons)

func show_main_buttons() -> void:
	fight.grab_focus()
	main_buttons_container.show()

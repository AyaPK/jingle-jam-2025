extends Node2D

const SKILL_MENU_BUTTON = preload("uid://c47btjjyvj32h")
@onready var skill_container: VBoxContainer = $CanvasLayer/ScrollContainer/SkillContainer
const SKILLMENULABEL = preload("uid://c2r1y5pt7agec")

func _ready() -> void:
	for _c in skill_container.get_children():
		_c.queue_free()
		await _c.tree_exited
	var label_1: Label = SKILLMENULABEL.instantiate()
	skill_container.add_child(label_1)
	label_1.text = "Insults"
	for dialog in PlayerManager.insult_dialog_pool:
		var SMB: SkillMenuButton = SKILL_MENU_BUTTON.instantiate()
		skill_container.add_child(SMB)
		SMB.dialog_resource = dialog
		SMB.create_text_string()
	var label_2: Label = SKILLMENULABEL.instantiate()
	skill_container.add_child(label_2)
	label_2.text = "Seductions"
	for dialog in PlayerManager.seduction_dialog_pool:
		var SMB: SkillMenuButton = SKILL_MENU_BUTTON.instantiate()
		skill_container.add_child(SMB)
		SMB.dialog_resource = dialog
		SMB.create_text_string()
	Signals.dialog_started.connect(hide_stuff)
	Signals.dialog_finished.connect(show_stuff)

func hide_stuff() -> void:
	$CanvasLayer/PanelContainer.hide()
	$CanvasLayer/SkillLabel.hide()
	$CanvasLayer/ScrollContainer.hide()

func show_stuff() -> void:
	$CanvasLayer/PanelContainer.show()
	$CanvasLayer/SkillLabel.show()
	$CanvasLayer/ScrollContainer.show()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_back_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

func _on_back_mouse_entered() -> void:
	$CanvasLayer/Back.grab_focus()

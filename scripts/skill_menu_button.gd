class_name SkillMenuButton extends Button

var dialog_resource: Dialog

func _ready() -> void:
	pass

func create_text_string() -> void:
	var dmg: String = str(dialog_resource.damage)
	var sed: String = str(dialog_resource.seduction)
	var nm: String = str(dialog_resource.name)
	text = nm + " | Damage: " + dmg + " | Seduction: " + sed

func _on_mouse_entered() -> void:
	grab_focus()

func _on_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

func _on_pressed() -> void:
	if !DialogPanel.dialog_visible:
		DialogPanel.push_text("You: "+dialog_resource.dialog_text)

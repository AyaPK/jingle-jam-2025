class_name SkillMenuButton extends Button

@onready var partner_icon: TextureRect = $PartnerIcon

var dialog_resource: Dialog

func create_text_string() -> void:
	var dmg: String = str(dialog_resource.damage)
	var sed: String = str(dialog_resource.seduction)
	var nm: String = str(dialog_resource.name)
	text = nm + " | Damage: " + dmg + " | Seduction: " + sed
	
	var dialog_source = dialog_resource.get_dialog_source()
	
	if dialog_source and dialog_source != "player":
		partner_icon.show()
		partner_icon.texture = load("res://assets/art/demons/{0}/{0}-headshot.png".format([dialog_source]))


func _on_mouse_entered() -> void:
	grab_focus()

func _on_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

func _on_pressed() -> void:
	if !DialogPanel.dialog_visible:
		DialogPanel.push_text("You: "+dialog_resource.dialog_text)

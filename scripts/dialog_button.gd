class_name DialogButton extends Button

var dialog_resource: Dialog

@onready var partner_icon: TextureRect = $PartnerIcon
@onready var sparkle_1: TextureRect = $Sparkle1
@onready var sparkle_2: TextureRect = $Sparkle2

func _on_pressed() -> void:
	BattleManager.player_turn = dialog_resource
	Signals.battle_turns_started.emit()
	AudioManager.play_sfx("press_button")

func _on_mouse_entered() -> void:
	grab_focus()
	AudioManager.play_sfx("hover_button")

func set_up_details() -> void:
	if dialog_resource:
		text = dialog_resource.name
		
		if dialog_resource.rarity == Dialog.DIALOG_RARITY.COMMON:
			sparkle_1.hide()
		if dialog_resource.rarity == Dialog.DIALOG_RARITY.COMMON or dialog_resource.rarity == Dialog.DIALOG_RARITY.RARE:
			sparkle_2.hide()
		
		var dialog_source = dialog_resource.resource_path.split("/")[-2]
		if dialog_source == "player":
			partner_icon.hide()
			return
		
		partner_icon.show()
		partner_icon.texture = load("res://assets/art/demons/{0}/{0}-headshot.png".format([dialog_source]))

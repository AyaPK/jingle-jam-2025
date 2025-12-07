class_name DemonButton extends Button

@export var demon: Demon
@onready var demon_headshot: Sprite2D = $DemonHeadshot
@onready var demon_beaten_icon: TextureRect = $DemonBeatenIcon

func _ready() -> void:
	if demon:
		text = " "+demon.demon_name
		demon_headshot.texture = demon.headshot
		if GameStateManager.demon_is_beaten(demon) or GameStateManager.demon_is_seduced(demon):
			disabled = true
			demon_headshot.self_modulate = Color()
			demon_beaten_icon.visible = true
			
		if GameStateManager.demon_is_beaten(demon):
			demon_beaten_icon.texture = load("res://assets/art/ui/sword.png")
		elif GameStateManager.demon_is_seduced(demon):
			demon_beaten_icon.texture = load("res://assets/art/ui/heart.png")

func _on_pressed() -> void:
	if !disabled:
		BattleManager.current_demon = demon
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
		AudioManager.play_sfx("press_button")
		
func _on_mouse_entered() -> void:
	if !disabled:
		grab_focus()
		AudioManager.play_sfx("hover_button")

func _on_focus_entered() -> void:
	AudioManager.play_sfx("hover_button")

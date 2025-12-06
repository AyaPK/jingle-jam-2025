class_name DemonButton extends Button

@export var demon: Demon
@onready var demon_headshot: Sprite2D = $DemonHeadshot

func _ready() -> void:
	if demon:
		text = " "+demon.demon_name
		demon_headshot.texture = demon.headshot
		if GameStateManager.demon_is_beaten(demon.internal_name) or GameStateManager.demon_is_seduced(demon.internal_name):
			disabled = true
			demon_headshot.self_modulate = Color()

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

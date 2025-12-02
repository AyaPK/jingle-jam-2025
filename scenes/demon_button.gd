class_name DemonButton extends Button

@export var demon: Demon
@onready var demon_headshot: Sprite2D = $DemonHeadshot

func _ready() -> void:
	if demon:
		text = " "+demon.demon_name
		demon_headshot.texture = demon.headshot

func _on_pressed() -> void:
	BattleManager.current_demon = demon

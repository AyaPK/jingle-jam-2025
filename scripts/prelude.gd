extends Node2D

@onready var prelude : VBoxContainer= $PreludeText
@onready var logo: TextureRect = $Logo

func _ready():
	# Start with both hidden
	prelude.modulate.a = 0
	logo.modulate.a = 0
	
	# Start the sequence
	await fade_sequence()

func fade_sequence():
	# Fade in node 1
	await fade_in(prelude, 1.0)
	
	# Wait
	await get_tree().create_timer(7.0).timeout
	
	# Fade out node 1
	await fade_out(prelude, 1.0)
	
	# Wait
	await get_tree().create_timer(1.0).timeout
	
	# Fade in node 2
	await fade_in(logo, 1.0)
	
	# Wait
	await get_tree().create_timer(4.0).timeout
	
	await fade_out(logo, 1.0)
	
	# Transition to next scene
	PreludeManager.prelude_shown = true
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func fade_in(node: CanvasItem, duration: float):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, duration)
	await tween.finished

func fade_out(node: CanvasItem, duration: float):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, duration)
	await tween.finished

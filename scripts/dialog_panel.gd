extends Node2D

var text_queue: Array[String] = []
var current_text: String = ""

var reveal_speed: float = 150.0
var _revealed_chars: int = 0
var _is_revealing: bool = false

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label: RichTextLabel = $CanvasLayer/TextureRect/Label

func _ready() -> void:
	label.text = ""
	canvas_layer.hide()

func push_text(text: String) -> void:
	text_queue.append(text)
	if not canvas_layer.visible:
		Signals.dialog_started.emit()
		_show_next_from_queue()

func _show_next_from_queue() -> void:
	if text_queue.is_empty():
		current_text = ""
		label.text = ""
		canvas_layer.hide()
		_is_revealing = false
		_revealed_chars = 0
		Signals.dialog_finished.emit()
		return

	current_text = text_queue.pop_front()
	_revealed_chars = 0
	_is_revealing = true
	label.text = ""
	canvas_layer.show()
	Signals.dialog_line_started.emit()

func _process(delta: float) -> void:
	if _is_revealing:
		_revealed_chars += int(reveal_speed * delta)
		if _revealed_chars >= current_text.length():
			_revealed_chars = current_text.length()
			_is_revealing = false
		label.text = current_text.substr(0, _revealed_chars)

func _unhandled_input(event: InputEvent) -> void:
	if not canvas_layer.visible:
		return

	if event.is_action_pressed("ui_accept"):
		if _is_revealing:
			_revealed_chars = current_text.length()
			_is_revealing = false
			label.text = current_text
			return

		if text_queue.is_empty():
			current_text = ""
			label.text = ""
			canvas_layer.hide()
			_is_revealing = false
			_revealed_chars = 0
			Signals.dialog_finished.emit()
		else:
			_show_next_from_queue()

extends HBoxContainer

@export var bus_name: String

@onready var bus_label := $BusLabel
@onready var mute_check_box := $MuteCheckBox
@onready var volume_slider := $VolumeSlider

@onready var bus_index: int = AudioServer.get_bus_index(bus_name)

func _ready() -> void:
	bus_label.text = bus_name+":"
	mute_check_box.button_pressed = AudioServer.is_bus_mute(bus_index)
	volume_slider.value = AudioServer.get_bus_volume_linear(bus_index)

func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(bus_index, toggled_on)

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)

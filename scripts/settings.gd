extends Node2D

@onready var music_mute_check_box = $CanvasLayer/PanelContainer/VBoxContainer/MusicVolume/MuteCheckBox
@onready var music_volume_slider = $CanvasLayer/PanelContainer/VBoxContainer/MusicVolume/VolumeSlider

@onready var sfx_mute_check_box = $CanvasLayer/PanelContainer/VBoxContainer/SfxVolume/MuteCheckBox
@onready var sfx_volume_slider = $CanvasLayer/PanelContainer/VBoxContainer/SfxVolume/VolumeSlider

func _ready() -> void:
	AudioManager.play_music("menu")
	music_mute_check_box.button_pressed = AudioServer.is_bus_mute(AudioManager.music_bus_idx)
	music_volume_slider.value = AudioServer.get_bus_volume_linear(AudioManager.music_bus_idx)
	sfx_mute_check_box.button_pressed = AudioServer.is_bus_mute(AudioManager.sfx_bus_idx)
	sfx_volume_slider.value = AudioServer.get_bus_volume_linear(AudioManager.sfx_bus_idx)

func _on_music_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioManager.music_bus_idx, toggled_on)

func _on_sfx_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioManager.sfx_bus_idx, toggled_on)

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioManager.music_bus_idx, value)

func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioManager.sfx_bus_idx, value)

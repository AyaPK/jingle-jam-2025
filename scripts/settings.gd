extends Node2D

@onready var music_mute_check_box = $CanvasLayer/PanelContainer/VBoxContainer/MusicVolume/MuteCheckBox
@onready var music_volume_slider = $CanvasLayer/PanelContainer/VBoxContainer/MusicVolume/VolumeSlider

@onready var sfx_mute_check_box = $CanvasLayer/PanelContainer/VBoxContainer/SfxVolume/MuteCheckBox
@onready var sfx_volume_slider = $CanvasLayer/PanelContainer/VBoxContainer/SfxVolume/VolumeSlider

func _ready() -> void:
	AudioManager.play_music("menu")
	music_mute_check_box.button_pressed = AudioManager.music_muted
	music_volume_slider.value = AudioManager.music_volume_linear
	sfx_mute_check_box.button_pressed = AudioManager.sfx_muted
	sfx_volume_slider.value = AudioManager.sfx_volume_linear

func _on_music_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioManager.set_music_mute(toggled_on)

func _on_sfx_mute_check_box_toggled(toggled_on: bool) -> void:
	AudioManager.set_sfx_mute(toggled_on)

func _on_music_volume_value_changed(value: float) -> void:
	AudioManager.set_music_volume_linear(value)

func _on_sfx_volume_value_changed(value: float) -> void:
	AudioManager.set_sfx_volume_linear(value)

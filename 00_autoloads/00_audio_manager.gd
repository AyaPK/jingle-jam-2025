extends Node

@export var music_bus_name: String = "Music"
@export var sfx_bus_name: String = "SFX"

var music_library: Dictionary = {
	"menu": preload("res://assets/music/menu1.ogg"),
	"battle": preload("res://assets/music/battle1.ogg")
}

var sfx_library: Dictionary = {
	"seduce": preload("res://assets/sfx/seduce.wav"),
	"hit": preload("res://assets/sfx/impact.wav"),
	"hover_button": preload("res://assets/sfx/hover.wav"),
	"back_button": preload("res://assets/sfx/back.wav"),
	"press_button": preload("res://assets/sfx/press.wav"),
	"give_gift": preload("res://assets/sfx/gift.wav")
}

var _music_player: AudioStreamPlayer

func _ready() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = music_bus_name
	add_child(_music_player)

func play_music(music: String) -> void:
	print("Playing")
	var stream: AudioStream = music_library.get(music)
	if stream == null:
		push_warning("AudioManager: music '" + music + "' not found in music_library")
		return
	if _music_player.stream == stream and _music_player.playing:
		return
	_music_player.stop()
	_music_player.stream = stream
	_music_player.play()

func stop_music() -> void:
	if _music_player and _music_player.playing:
		_music_player.stop()

func play_sfx(sfx: String) -> void:
	var stream: AudioStream = sfx_library.get(sfx)
	if stream == null:
		push_warning("AudioManager: sfx '" + sfx + "' not found in sfx_library")
		return
	var player := AudioStreamPlayer.new()
	player.bus = sfx_bus_name
	player.stream = stream
	add_child(player)
	player.finished.connect(func() -> void:
		player.queue_free()
	)
	player.play()

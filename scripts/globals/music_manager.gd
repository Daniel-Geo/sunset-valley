extends Node

enum Music {
	Menu,
	Cutscene,
	Game
}

@onready var music_map: Dictionary = {
	Music.Menu: $MenuMusic,
	Music.Cutscene: $CutsceneMusic,
	Music.Game: $GameMusic
}

@export var fade_duration: float = 2.0

var current_music: Music = Music.Menu

func _ready() -> void:
	$MenuMusic.play()

func play_music(music: Music) -> void:
	if music == current_music:
		return
	current_music = music
	
	for player: AudioStreamPlayer in music_map.values():
		if player.playing:
			fade_out(player)
	fade_in(music_map[music])

func fade_out(player: AudioStreamPlayer) -> void:
	var tween = create_tween()
	tween.tween_method(
		func(volume: float): player.volume_db = linear_to_db(volume),
		db_to_linear(player.volume_db),
		0.0,
		fade_duration
	)

func fade_in(player: AudioStreamPlayer) -> void:
	player.volume_db = -80.0
	player.play()
	var tween = create_tween()
	tween.tween_method(
		func(volume: float): player.volume_db = linear_to_db(volume),
		0.0,
		1.0,
		fade_duration
	)

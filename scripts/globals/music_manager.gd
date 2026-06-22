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

@export var fade_duration: float = 0.75

var current_music: Music = -1 as Music
var tween: Tween

func _ready() -> void:
	$MenuMusic.play()

func play_music(music: Music) -> void:
	if music == current_music:
		return
	current_music = music
	if tween:
		tween.kill()
	tween = create_tween()
	
	for player: AudioStreamPlayer in music_map.values():
		if player.playing:
			tween.tween_property(player, "volume_db", -80.0, fade_duration)
	
	var next: AudioStreamPlayer = music_map[music]
	next.volume_db = -80.0
	next.play()
	tween.tween_property(next, "volume_db", 0.0, fade_duration)

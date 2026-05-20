extends Timer

@export var audio_stream_player_2D: AudioStreamPlayer2D

func _ready() -> void:
	wait_time = randi_range(5, 25)

func _on_timeout() -> void:
	audio_stream_player_2D.play()

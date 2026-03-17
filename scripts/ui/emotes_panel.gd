extends Panel
@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes: Array = ["emote1_idle", "emote2_smile", "emote3_ear_wave", "emote4_blink"]

func _ready() -> void:
	animated_sprite_2d.play("emote1_idle")


func play_emote(animation: String) -> void:
	animated_sprite_2d.play(animation)


func _on_emote_idle_timer_timeout() -> void:
	var index: int = randi_range(0, 3)
	var emote: String = idle_emotes[index]
	animated_sprite_2d.play(emote)

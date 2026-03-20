extends Panel
@onready var animated_sprite_2d: AnimatedSprite2D = $Emote/AnimatedSprite2D
@onready var emote_idle_timer: Timer = $EmoteIdleTimer

var idle_emotes: Array = ["emote1_idle", "emote2_smile", "emote3_ear_wave", "emote4_blink"]

func _ready() -> void:
	animated_sprite_2d.play("emote1_idle")
	InventoryManager.inventory_changed.connect(on_inventory_changed)
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)

func play_emote(animation: String) -> void:
	animated_sprite_2d.play(animation)

func _on_emote_idle_timer_timeout() -> void:
	var index: int = randi_range(0, 3)
	var emote: String = idle_emotes[index]
	animated_sprite_2d.play(emote)

func on_inventory_changed() -> void:
	animated_sprite_2d.play("emote7_excited")

func on_feed_the_animals() -> void:
	animated_sprite_2d.play("emote6_love_kiss")

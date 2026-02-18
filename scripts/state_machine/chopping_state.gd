extends NodeState

@export var player: Player
@export var animated_sprite: AnimatedSprite2D


func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	pass

func _on_next_transition() -> void:
	if !animated_sprite.is_playing():
		transition.emit("Idle")

func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite.play("chopping_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite.play("chopping_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite.play("chopping_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite.play("chopping_right")
	else:
		animated_sprite.play("chopping_front")

func _on_exit() -> void:
	animated_sprite.stop()

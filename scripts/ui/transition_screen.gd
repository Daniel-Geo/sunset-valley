extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished

func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(on_animation_finished)

func transition() -> void:
	color_rect.visible = true
	animation_player.play("fade_to_black")

func on_animation_finished(animation_name) -> void:
	if animation_name == "fade_to_black":
		animation_player.play("fade_to_normal")
		transition_finished.emit()
	elif animation_name == "fade_to_normal":
		color_rect.visible = false

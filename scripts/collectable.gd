extends StaticBody2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var sprite: Sprite2D = $Sprite2D

@export var collictable_scene: PackedScene
@export var shake_intensity: float
@export var timer: float

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)


func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	sprite.material.set_shader_parameter("shake_intensity", shake_intensity)
	await get_tree().create_timer(timer).timeout
	sprite.material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	call_deferred("add_collictable_scene")
	queue_free()

func add_collictable_scene() -> void:
	var collictable_instance = collictable_scene.instantiate() as Node2D
	collictable_instance.global_position = global_position
	get_parent().add_child(collictable_instance)

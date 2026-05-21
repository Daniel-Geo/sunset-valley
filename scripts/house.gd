extends Node2D

@export var roof_fade_time: float = 1.0
@export var roof_modulate_fade: float = 0.05

@onready var auto_interactable_component: AutoInteractableComponent = $AutoInteractableComponent
@onready var timer: Timer = $Timer

var roof: TileMapLayer

func _ready() -> void:
	auto_interactable_component.interactable_activated.connect(on_interactable_activated)
	auto_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	roof = get_node("HouseTilemap/Roof")
	timer.wait_time = roof_fade_time * roof_modulate_fade

func on_interactable_activated() -> void:
	timer.start()
	for i in range(1 / roof_modulate_fade):
		roof.modulate.a -= roof_modulate_fade
		await timer.timeout

func on_interactable_deactivated() -> void:
	timer.start()
	for i in range(1 / roof_modulate_fade):
		roof.modulate.a += roof_modulate_fade
		await timer.timeout

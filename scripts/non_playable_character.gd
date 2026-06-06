class_name NonPlayableCharacter
extends CharacterBody2D

@export var min_walk_cycle: int = 2
@export var max_walk_cycle: int = 6
@export var output_reward_scenes: Array[PackedScene] = []

@onready var rewards: Node2D

var walk_cycles: int
var current_walk_cycle: int

func _ready() -> void:
	rewards = %Rewards
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)

func add_reward() -> void:
	for scene in output_reward_scenes:
		var reward_scene: Node2D = scene.instantiate()
		reward_scene.global_position = position
		rewards.add_child(reward_scene)

class_name Player
extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: NodeStateMachine = $StateMachine
@onready var hit_component: HitComponent = $HitComponent

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

var player_direction: Vector2

func _ready() -> void: 
	ToolManager.tool_selected.connect(on_tool_selected)
	DialogueManager.dialogue_started.connect(on_dialogue_started)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)

func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool

func on_dialogue_started(_resource: DialogueResource) -> void:
	print("started")
	if player_direction == Vector2.UP:
		animated_sprite.play("idle_back")
	elif player_direction == Vector2.DOWN:
		animated_sprite.play("idle_front")
	elif player_direction == Vector2.LEFT:
		animated_sprite.play("idle_left")
	elif player_direction == Vector2.RIGHT:
		animated_sprite.play("idle_right")
	
	state_machine.process_mode = Node.PROCESS_MODE_DISABLED

func on_dialogue_ended(_resource: DialogueResource) -> void:
	print("ended")
	state_machine.process_mode = Node.PROCESS_MODE_INHERIT

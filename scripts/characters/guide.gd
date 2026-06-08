extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var auto_interactable_component: AutoInteractableComponent = $AutoInteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool

class GuideState:
	var interactable_label_component: Control

var dialogue_variables = GuideState.new()

func _ready() -> void:
	dialogue_variables.interactable_label_component = interactable_label_component
	auto_interactable_component.interactable_activated.connect(on_interactable_activated)
	auto_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	GameDialogueManager.give_crop_seeds.connect(on_give_crop_seeds)

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("interact"):
		interactable_label_component.hide()
		DialogueManager.show_dialogue_balloon_scene(balloon_scene, load("res://dialogue/conversations/guide.dialogue"), "start", [dialogue_variables])

func on_give_crop_seeds() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantCorn)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantTomato)

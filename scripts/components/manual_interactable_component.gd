class_name ManualInteractableComponent
extends Area2D

@onready var interactable_label_component: Control = $InteractableLabelComponent

var is_player_nearby: bool = false
var is_active: bool = false

signal interactable_activated
signal interactable_deactivated

func _ready() -> void:
	interactable_label_component.hide()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_nearby = true
	get_node("InteractableLabelComponent").show()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_nearby = false
	get_node("InteractableLabelComponent").hide()

func _unhandled_input(event: InputEvent) -> void:
	if is_player_nearby and Input.is_action_just_pressed("interact"):
		is_active = !is_active
		if is_active:
			interactable_activated.emit()
		else:
			interactable_deactivated.emit()
	

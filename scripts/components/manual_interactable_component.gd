class_name ManualInteractableComponent
extends Area2D

var is_player_nearby: bool = false
var is_active: bool = false

signal interactable_activated
signal interactable_deactivated


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_nearby = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_nearby = false

func _unhandled_input(event: InputEvent) -> void:
	if is_player_nearby and Input.is_action_just_pressed("interact"):
		is_active = !is_active
		if is_active:
			interactable_activated.emit()
		else:
			interactable_deactivated.emit()
	

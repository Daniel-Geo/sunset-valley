class_name NodeDataResource
extends Resource

@export var global_position: Vector2
@export var node_path: NodePath
@export var parent_node_path: NodePath

func _save_data(node: Node2D) -> void:
	global_position = node.global_position
	node_path = node.get_path()
	
	var parent_node = node.get_parent()
	if parent_node != null:
		parent_node_path = parent_node.get_path()

func _load_data(window: Window) -> void:
	pass

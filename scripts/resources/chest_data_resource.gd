extends NodeDataResource

@export var starting_day: int
@export var food_storage: int

func _save_data(node: Node2D) -> void:
	super._save_data(node)
	
	starting_day = node.starting_day
	food_storage = node.food_storage

func _load_data(window: Window) -> void:
	print(node_path)
	var parent_node = window.get_node_or_null(node_path)
	
	parent_node.starting_day = starting_day
	parent_node.food_storage = food_storage

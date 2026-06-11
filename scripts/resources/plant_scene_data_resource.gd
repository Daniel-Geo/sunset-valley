extends SceneDataResource

@export var is_watered: bool
@export var starting_day: int
@export var current_day: int

func _save_data(node: Node2D) -> void:
	super._save_data(node)
	
	var growth_cycle_component = node.get_node_or_null("GrowthCycleComponent")
	
	is_watered = growth_cycle_component.is_watered
	starting_day = growth_cycle_component.starting_day
	current_day = growth_cycle_component.current_day

func _load_data(window: Window) -> void:
	super._load_data(window)
	
	var growth_cycle_component = scene_node.get_node_or_null("GrowthCycleComponent")
	
	growth_cycle_component.is_watered = is_watered
	growth_cycle_component.starting_day = starting_day
	growth_cycle_component.current_day = current_day
	
	if parent_node != null and scene_node != null:
		scene_node.global_position = global_position
		parent_node.add_child(scene_node)

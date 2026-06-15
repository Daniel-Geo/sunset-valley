class_name CropsCursorComponent
extends Node

@export var tilled_soil_tilemap_layer: TileMapLayer

@onready var crop_fields: Node2D = %CropFields

var player: Player

var corn_plant_scene = preload("res://scenes/objects/plants/corn/corn.tscn")
var tomato_plant_scene = preload("res://scenes/objects/plants/tomato/tomato.tscn")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn or ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			remove_crop()
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn or ToolManager.selected_tool == DataTypes.Tools.PlantTomato:
			get_cell_under_mouse()
			if !has_crop(local_cell_position):
				add_crop()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(local_cell_position)

func add_crop() -> void:
	if distance < 20.0  and cell_source_id != -1:
		if ToolManager.selected_tool == DataTypes.Tools.PlantCorn and InventoryManager.inventory.has("corn seed"):
			if InventoryManager.inventory["corn seed"] > 0:
				var corn_instance = corn_plant_scene.instantiate() as Node2D
				corn_instance.global_position = local_cell_position
				crop_fields.add_child(corn_instance)
				InventoryManager.remove_collectable("corn seed")
		
		elif ToolManager.selected_tool == DataTypes.Tools.PlantTomato and InventoryManager.inventory.has("tomato seed"):
			if InventoryManager.inventory["tomato seed"] > 0:
				var tomato_instance = tomato_plant_scene.instantiate() as Node2D
				tomato_instance.global_position = local_cell_position
				crop_fields.add_child(tomato_instance)
				InventoryManager.remove_collectable("tomato seed")

func remove_crop() -> void:
	if distance < 20.0:
		var crop_nodes = get_parent().find_child("CropFields").get_children()
		
		for node: Node2D in crop_nodes:
			if node.global_position == local_cell_position:
				node.queue_free()

func has_crop(pos: Vector2) -> bool:
	for node: Node2D in crop_fields.get_children():
		if node.global_position == pos:
			return true
	return false

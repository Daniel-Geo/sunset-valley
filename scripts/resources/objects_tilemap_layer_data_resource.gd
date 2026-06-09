class_name ObjectsTilemapLayerDataResource
extends NodeDataResource

@export var cells_map_position: Array[Vector2i]
@export var source_ids: Array[int]
@export var atlas_coords: Array[Vector2]
@export var alternative_ids: Array[int]

func _save_data(node: Node2D) -> void:
	super._save_data(node)
	
	var tilemap_layer: TileMapLayer = node as TileMapLayer
	cells_map_position = tilemap_layer.get_used_cells()

	source_ids.clear()
	atlas_coords.clear()
	alternative_ids.clear()
	for cell in cells_map_position.size():
		source_ids.append(tilemap_layer.get_cell_source_id(cells_map_position[cell]))
		atlas_coords.append(tilemap_layer.get_cell_atlas_coords(cells_map_position[cell]))
		alternative_ids.append(tilemap_layer.get_cell_alternative_tile(cells_map_position[cell]))

func _load_data(window: Window) -> void:
	var scene_node = window.get_node_or_null(node_path)
	
	if scene_node != null:
		var tilemap_layer: TileMapLayer = scene_node as TileMapLayer
		tilemap_layer.clear()
		for cell in cells_map_position.size():
			tilemap_layer.set_cell(cells_map_position[cell], source_ids[cell], atlas_coords[cell], alternative_ids[cell])

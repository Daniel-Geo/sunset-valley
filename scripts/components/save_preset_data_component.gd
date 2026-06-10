class_name SavePresetDataComponent
extends Node

var preset_scene_name: String
var save_game_data_path: String = "user://game_data/"
var save_file_name: String = "save_%s_game_data.tres"
var game_data_resource: SaveGameDataResource

func _ready() -> void:
	add_to_group("save_preset_data_component")
	preset_scene_name = get_parent().name

func save_node_data() -> void:
	var nodes = get_tree().get_nodes_in_group("save_data_component")
	
	game_data_resource = SaveGameDataResource.new()
	
	if nodes != null:
		for node: SaveDataComponent in nodes:
			if node is SaveDataComponent:
				var save_data_resource: NodeDataResource = node._save_data()
				var save_final_resource = save_data_resource.duplicate()
				game_data_resource.save_data_nodes.append(save_final_resource)


func save_game() -> void:
	if !DirAccess.dir_exists_absolute(save_game_data_path):
		DirAccess.make_dir_absolute(save_game_data_path)

	var preset_save_file_name: String = save_file_name % preset_scene_name

	save_node_data()

	game_data_resource.guide_met = GameDialogueManager.guide_met
	game_data_resource.inventory = InventoryManager.inventory
	game_data_resource.coins = CoinsManager.coins
	game_data_resource.water_value = WaterManager.water_value
	game_data_resource.time = DayAndNightCycleManager.time
	game_data_resource.tools_enabled = ToolManager.tools_enabled

	var result: int = ResourceSaver.save(game_data_resource, save_game_data_path + preset_save_file_name)
	SaveGameManager.check_saved_game_data()
	print("Save result: ", result)

func load_game() -> void:
	var preset_save_file_name: String = save_file_name % preset_scene_name
	var save_game_path: String = save_game_data_path + preset_save_file_name

	if !FileAccess.file_exists(save_game_path):
		return

	game_data_resource = ResourceLoader.load(save_game_path)
	if game_data_resource == null:
		return

	GameDialogueManager.guide_met = game_data_resource.guide_met
	InventoryManager.inventory = game_data_resource.inventory
	InventoryManager.inventory_changed.emit()
	CoinsManager.coins = game_data_resource.coins
	CoinsManager.coins_changed.emit()
	WaterManager.water_value = game_data_resource.water_value
	WaterManager.water_changed.emit()
	DayAndNightCycleManager.time = game_data_resource.time
	DayAndNightCycleManager.recalculate_time()
	ToolManager.tools_enabled = game_data_resource.tools_enabled
	ToolManager.tools_state_changed.emit()

	var root_node: Window = get_tree().root

	for resource in game_data_resource.save_data_nodes:
		if resource is Resource:
			if resource is NodeDataResource:
				resource._load_data(root_node)

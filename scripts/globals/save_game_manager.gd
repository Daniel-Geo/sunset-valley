extends Node

var data: SaveGameDataResource
var allow_save_game: bool

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		save_game()

func save_game() -> void:
	var save_preset_data_component: SavePresetDataComponent = get_tree().get_first_node_in_group("save_preset_data_component")
	if save_preset_data_component != null:
		save_preset_data_component.save_game()

func load_game() -> void:
	await get_tree().process_frame

	var save_preset_data_component: SavePresetDataComponent = get_tree().get_first_node_in_group("save_preset_data_component")
	if save_preset_data_component != null:
		save_preset_data_component.load_game()

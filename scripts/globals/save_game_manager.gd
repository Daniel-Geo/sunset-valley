extends Node

var data: SaveGameDataResource
var allow_save_game: bool
var allow_load_game: bool

var save_game_data_path: String = "user://game_data/"

signal load_state_changed

func _ready() -> void:
	check_saved_game_data()

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

func check_saved_game_data() -> void:
	var files = DirAccess.get_files_at(save_game_data_path)
	if files.size() == 0:
		allow_load_game = false
	else:
		allow_load_game = true
	load_state_changed.emit()

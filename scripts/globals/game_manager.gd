extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")
var game_over_screen = preload("res://scenes/ui/game_over_screen.tscn")

signal dialogue_finished

func _ready() -> void:
	dialogue_finished.connect(on_dialogue_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		show_game_menu_screen()

func start_game() -> void:
	reset_data()
	SceneManager.load_main_scene_container()
	SceneManager.load_preset("Grandpa", "cutscene")
	await SceneManager.finished_cutscene
	SceneManager.load_preset("Preset1", "preset")
	SaveGameManager.allow_save_game = true

func load_game() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_preset("Preset1", "preset")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true

func exit_game() -> void:
	get_tree().quit()

func show_game_menu_screen() -> void:
	if get_tree().root.get_node_or_null("/root/GameMenuScreen") == null:
		var game_menu_screen_instance = game_menu_screen.instantiate()
		get_tree().root.add_child(game_menu_screen_instance)

func show_game_over_screen() -> void:
	var game_over_screen_instance = game_over_screen.instantiate()
	get_tree().root.add_child(game_over_screen_instance)

func on_dialogue_finished() -> void:
	TransitionScreen.transition()

func reset_data() -> void:
	GameDialogueManager.guide_met = false
	InventoryManager.reset_inventory()
	CoinsManager.reset_coins()
	WaterManager.refill_water()
	DayAndNightCycleManager.set_initial_time()
	ToolManager.disable_tools.emit()

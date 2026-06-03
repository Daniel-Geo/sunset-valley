extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")
var game_over_screen = preload("res://scenes/ui/game_over_screen.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		WaterManager.timer.stop()
		show_game_menu_screen()

func start_game() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_preset("Preset1")
	SaveGameManager.allow_save_game = true
	WaterManager.timer.start()
	WaterManager.water_value = 100
	WaterManager.water_consumer_nums = 0

func load_game() -> void:
	SceneManager.load_main_scene_container()
	SceneManager.load_preset("Preset1")
	SaveGameManager.load_game()
	SaveGameManager.allow_save_game = true
	WaterManager.timer.start()
	WaterManager.water_value = 100
	WaterManager.water_consumer_nums = 0

func exit_game() -> void:
	get_tree().quit()

func show_game_menu_screen() -> void:
	if get_tree().root.get_node_or_null("/root/GameMenuScreen") == null:
		var game_menu_screen_instance = game_menu_screen.instantiate()
		get_tree().root.add_child(game_menu_screen_instance)

func show_game_over_screen() -> void:
	var game_over_screen_instance = game_over_screen.instantiate()
	get_tree().root.add_child(game_over_screen_instance)

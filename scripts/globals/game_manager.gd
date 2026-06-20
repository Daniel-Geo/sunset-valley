extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")
var game_over_screen = preload("res://scenes/ui/game_over_screen.tscn")
var game_win_screen = preload("res://scenes/ui/game_win_screen.tscn")

var is_showing_screen: bool = false
var is_playing_cutscenes: bool = false
var game_over: bool = false
var endless_mode: bool = false
var allow_continue_and_save_game: bool = false

signal dialogue_finished
signal reset_game_speed

func _ready() -> void:
	dialogue_finished.connect(on_dialogue_finished)
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu") and !is_playing_cutscenes:
		show_game_menu_screen()

func start_game() -> void:
	reset_data()
	SceneManager.load_main_scene_container()
	is_playing_cutscenes = true
	SceneManager.load_preset("Grandpa", "cutscene")
	await SceneManager.finished_cutscene
	SceneManager.load_preset("Valley", "cutscene")
	await SceneManager.finished_cutscene
	SceneManager.load_preset("Preset1", "preset")
	is_playing_cutscenes = false
	SaveGameManager.allow_save_game = true
	GameManager.allow_continue_and_save_game = true
	DayAndNightCycleManager.process_mode = Node.PROCESS_MODE_INHERIT

func load_game() -> void:
	reset_data()
	SceneManager.load_main_scene_container()
	SceneManager.load_preset("Preset1", "preset")
	await SaveGameManager.load_game()
	allow_continue_and_save_game = true
	SaveGameManager.allow_save_game = true
	DayAndNightCycleManager.process_mode = Node.PROCESS_MODE_INHERIT
	if game_over:
		show_game_over_screen()

func exit_game() -> void:
	get_tree().quit()

func show_game_menu_screen() -> void:
	if get_tree().root.get_node_or_null("/root/GameMenuScreen") == null:
		print(get_tree().current_scene)
		if get_tree().root.get_node_or_null("/root/GameCreditsScreen") != null or get_tree().root.get_node_or_null("/root/GameOverScreen") != null:
			get_tree().change_scene_to_file("res://scenes/ui/game_menu_screen.tscn")
		else:
			var game_menu_screen_instance = game_menu_screen.instantiate()
			get_tree().root.add_child(game_menu_screen_instance)

func show_game_over_screen() -> void:
	if get_tree().root.get_node_or_null("/root/GameOverScreen") == null and !is_showing_screen:
		is_showing_screen = true
		allow_continue_and_save_game = false
		TransitionScreen.transition()
		await TransitionScreen.transition_finished
		var game_over_screen_instance = game_over_screen.instantiate()
		get_tree().root.add_child(game_over_screen_instance)
		get_tree().current_scene = game_over_screen_instance
		is_showing_screen = false

func show_game_win_screen() -> void:
	if get_tree().root.get_node_or_null("/root/GameWinScreen") == null and !is_showing_screen:
		is_showing_screen = true
		allow_continue_and_save_game = false
		TransitionScreen.transition()
		await TransitionScreen.transition_finished
		var game_win_screen_instance = game_win_screen.instantiate()
		get_tree().root.add_child(game_win_screen_instance)
		get_tree().current_scene = game_win_screen_instance
		is_showing_screen = false

func on_dialogue_finished() -> void:
	TransitionScreen.transition()

func on_time_tick_day(day: int) -> void:
	if day > 100 and !endless_mode:
		DayAndNightCycleManager.process_mode = Node.PROCESS_MODE_DISABLED
		print(CoinsManager.coins)
		print(game_over)
		print(endless_mode)
		if CoinsManager.coins >= 1000:
			show_game_win_screen()
		else:
			game_over = true
			show_game_over_screen()

func reset_data() -> void:
	GameDialogueManager.guide_met = false
	InventoryManager.reset_inventory()
	CoinsManager.reset_coins()
	WaterManager.refill_water()
	ToolManager.disable_tools.emit()
	DayAndNightCycleManager.set_initial_time()
	DayAndNightCycleManager.game_time.emit(DayAndNightCycleManager.time)
	DayAndNightCycleManager.process_mode = Node.PROCESS_MODE_DISABLED
	reset_game_speed.emit()
	endless_mode = false
	allow_continue_and_save_game = false
	game_over = false

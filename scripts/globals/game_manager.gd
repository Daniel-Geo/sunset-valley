extends Node

var game_menu_screen = preload("res://scenes/ui/game_menu_screen.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("game_menu"):
		show_game_menu_screen()

func start_game() -> void:
	SceneManager.load_level("Level1")

func show_game_menu_screen() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/game_menu_screen.tscn")

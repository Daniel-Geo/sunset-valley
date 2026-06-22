extends CanvasLayer

@onready var load_game_button: Button = $MarginContainer/VBoxContainer/LoadGameButton

func _ready() -> void:
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_save_game else Control.FOCUS_NONE

func _on_play_again_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.start_game()
	queue_free()

func _on_endless_mode_button_pressed() -> void:
	GameManager.endless_mode = true
	GameManager.allow_continue_and_save_game = true
	DayAndNightCycleManager.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()

func _on_load_game_button_pressed() -> void:
	MusicManager.play_music(MusicManager.Music.Game)
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.load_game()
	queue_free()

func _on_menu_game_button_pressed() -> void:
	MusicManager.play_music(MusicManager.Music.Menu)
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.show_game_menu_screen()
	queue_free()

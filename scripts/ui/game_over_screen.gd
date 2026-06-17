extends CanvasLayer

@onready var load_game_button: Button = $MarginContainer/VBoxContainer/LoadGameButton

func _ready() -> void:
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_save_game else Control.FOCUS_NONE

func _on_try_again_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.start_game()
	queue_free()

func _on_load_game_button_pressed() -> void:
	GameManager.load_game()
	queue_free()

func _on_menu_game_button_pressed() -> void:
	GameManager.show_game_menu_screen()
	queue_free()

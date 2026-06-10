extends CanvasLayer

@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton
@onready var load_game_button: Button = $MarginContainer/VBoxContainer/LoadGameButton

func _ready() -> void:
	SaveGameManager.check_saved_game_data()
	save_game_button.disabled = !SaveGameManager.allow_save_game
	save_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_save_game else Control.FOCUS_NONE
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_NONE if SaveGameManager.allow_load_game else Control.FOCUS_ALL
	SaveGameManager.load_state_changed.connect(on_load_state_changed)
	

func on_load_state_changed() -> void:
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_NONE if SaveGameManager.allow_load_game else Control.FOCUS_ALL

func _on_start_game_button_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.start_game()
	queue_free()

func _on_load_game_button_pressed() -> void:
	GameManager.load_game()
	queue_free()

func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()

func _on_credits_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/game_credits_screen.tscn")

func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game()

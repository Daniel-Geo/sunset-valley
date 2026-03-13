extends CanvasLayer

func _on_start_game_button_pressed() -> void:
	GameManager.start_game()
	queue_free()

extends CanvasLayer

func _on_try_again_button_pressed() -> void:
	GameManager.start_game()
	queue_free()

extends CanvasLayer

func _on_try_again_button_pressed() -> void:
	GameManager.show_game_menu_screen()
	queue_free()

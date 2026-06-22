extends CanvasLayer

@onready var continue_game_button: Button = $MarginContainer/VBoxContainer/ContinueGameButton
@onready var save_game_button: Button = $MarginContainer/VBoxContainer/SaveGameButton
@onready var load_game_button: Button = $MarginContainer/VBoxContainer/LoadGameButton
@onready var exit_game_button: Button = $MarginContainer/VBoxContainer/ExitGameButton
@onready var music_button: Button = $MarginContainer/HBoxContainer/MusicButton
@onready var sfx_button: Button = $MarginContainer/HBoxContainer/SFXButton


var music_bus_index: int = AudioServer.get_bus_index("Music")
var sfx_bus_index: int = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	if OS.has_feature("web"):
		exit_game_button.visible = false
	SaveGameManager.check_saved_game_data()
	continue_game_button.disabled = !(SaveGameManager.allow_save_game and GameManager.allow_continue_and_save_game)
	continue_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_save_game and GameManager.allow_continue_and_save_game else Control.FOCUS_NONE
	save_game_button.disabled = !(SaveGameManager.allow_save_game and GameManager.allow_continue_and_save_game)
	save_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_save_game and GameManager.allow_continue_and_save_game else Control.FOCUS_NONE
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_load_game else Control.FOCUS_NONE
	music_button.button_pressed = AudioServer.is_bus_mute(music_bus_index)
	sfx_button.button_pressed = AudioServer.is_bus_mute(sfx_bus_index)
	SaveGameManager.load_state_changed.connect(on_load_state_changed)

func on_load_state_changed() -> void:
	load_game_button.disabled = !SaveGameManager.allow_load_game
	load_game_button.focus_mode = Control.FOCUS_ALL if SaveGameManager.allow_load_game else Control.FOCUS_NONE

func _on_start_game_button_pressed() -> void:
	MusicManager.play_music(MusicManager.Music.Cutscene)
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.start_game()
	queue_free()

func _on_continue_game_button_pressed() -> void:
	MusicManager.play_music(MusicManager.Music.Game)
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	queue_free()

func _on_load_game_button_pressed() -> void:
	MusicManager.play_music(MusicManager.Music.Game)
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	GameManager.load_game()
	queue_free()

func _on_save_game_button_pressed() -> void:
	SaveGameManager.save_game()

func _on_credits_game_button_pressed() -> void:
	var game_credits_screen_instance: CanvasLayer = load("res://scenes/ui/game_credits_screen.tscn").instantiate()
	game_credits_screen_instance.layer = 2
	add_child(game_credits_screen_instance)

func _on_exit_game_button_pressed() -> void:
	GameManager.exit_game()


func _on_music_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(music_bus_index, true) if toggled_on else AudioServer.set_bus_mute(music_bus_index, false)


func _on_sfx_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(sfx_bus_index, true) if toggled_on else AudioServer.set_bus_mute(sfx_bus_index, false)

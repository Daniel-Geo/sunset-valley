class_name TestSceneSaveDataManagerComponent
extends Node

func _ready() -> void:
	call_deferred("load_test_scene")

func load_test_scene() -> void:
	SaveGameManager.load_game()

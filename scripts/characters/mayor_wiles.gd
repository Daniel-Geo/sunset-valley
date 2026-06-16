extends Node

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon_scene(balloon_scene, preload("res://dialogue/conversations/mayor_wiles.dialogue"))

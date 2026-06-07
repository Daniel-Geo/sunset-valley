extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

func _ready() -> void:
	var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
	get_tree().root.add_child(balloon)
	balloon.start(load("res://dialogue/conversations/grandpa.dialogue"))

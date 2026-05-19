extends Node

var level_scenes: Dictionary = {
	"MainScene": "res://scenes/main_scene.tscn"
}

func load_level(level: String) -> void:
	var scene_path: String = level_scenes.get(level)
	if scene_path == null:
		return
	
	get_tree().change_scene_to_file(scene_path)

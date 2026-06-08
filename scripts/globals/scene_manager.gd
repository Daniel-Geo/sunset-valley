extends Node

var main_scene_path: String = "res://scenes/main_scene.tscn"
var main_scene_root_path: String = "/root/MainScene"
var main_scene_preset_root_path: String = "/root/MainScene/GameRoot/PresetRoot"

var preset_scenes: Dictionary = {
	"Preset1": "res://scenes/presets/preset_1.tscn"
}

signal cutscenes_finished

func load_cutscenes() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscenes/grandpa_house.tscn")
	await GameManager.dialogue_finished
	TransitionScreen.transition()
	await TransitionScreen.transition_finished
	get_parent().get_child(11).queue_free()
	cutscenes_finished.emit()

func load_main_scene_container() -> void:
	if get_tree().root.has_node(main_scene_root_path):
		return
	
	var node: Node = load(main_scene_path).instantiate()
	if node != null:
		get_tree().root.add_child(node)
	
func load_preset(preset: String) -> void:
	var scene_path: String = preset_scenes.get(preset)
	var preset_scene: Node = load(scene_path).instantiate()
	var preset_root: Node = get_node(main_scene_preset_root_path)
	if preset_root != null:
		var nodes = preset_root.get_children()
		if nodes != null:
			for node: Node in nodes:
				node.queue_free()
		
		await get_tree().process_frame
		preset_root.add_child(preset_scene)

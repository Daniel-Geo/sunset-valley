extends BaseGameDialogueBalloon

@onready var emotes_panel: Panel = $Balloon/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/EmotesPanel


func start(with_dialogue_resource: DialogueResource = null, title: String = "", extra_game_states: Array = []) -> void:
	super.start(with_dialogue_resource, title, extra_game_states)
	emotes_panel.play_emote("emote12_talking")

func next(next_id: String) -> void:
	super.next(next_id)
	emotes_panel.play_emote("emote12_talking")
	

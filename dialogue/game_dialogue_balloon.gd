extends BaseGameDialogueBalloon

@onready var emotes_panel: Panel = $Balloon/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/EmotesPanel
@onready var bleep_sfx: AudioStreamPlayer = $BleepSFX

const SKIP_CHARACTERS: String = " .,!?-_|\n"

func _ready() -> void:
	super()
	dialogue_label.spoke.connect(on_spoke)

func start(with_dialogue_resource: DialogueResource = null, title: String = "", extra_game_states: Array = []) -> void:
	super(with_dialogue_resource, title, extra_game_states)
	emotes_panel.play_emote("emote12_talking")

func next(next_id: String) -> void:
	super(next_id)
	emotes_panel.play_emote("emote12_talking")

func on_spoke(letter: String, index: int, wait_time: float) -> void:
	if letter in SKIP_CHARACTERS:
		return
	if not bleep_sfx.playing:
		bleep_sfx.pitch_scale = randf_range(0.9, 1.1)
		bleep_sfx.play()

extends StaticBody2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

@onready var auto_interactable_component: AutoInteractableComponent = $AutoInteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

class ShopState:
	var item_name: String
	var item_price: int

var dialogue_variables = ShopState.new()
var in_range: bool

func _ready() -> void:
	auto_interactable_component.interactable_activated.connect(on_interactable_activated)
	auto_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("interact"):
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().root.add_child(balloon)
		balloon.start(load("res://dialogue/conversations/shop.dialogue"), "start", [dialogue_variables])

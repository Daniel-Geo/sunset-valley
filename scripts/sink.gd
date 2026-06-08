extends StaticBody2D

@onready var auto_interactable_component: AutoInteractableComponent = $AutoInteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool = false

func _ready() -> void:
	interactable_label_component.hide()
	auto_interactable_component.interactable_activated.connect(on_interactable_activated)
	auto_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(_event: InputEvent) -> void:
	if in_range and Input.is_action_just_pressed("interact"):
		WaterManager.refill_water()

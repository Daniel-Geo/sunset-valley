extends StaticBody2D

@onready var manual_interactable_component: ManualInteractableComponent = $ManualInteractableComponent
@onready var label: Label = $Label

var need_repair: bool = false

func _ready() -> void:
	manual_interactable_component.interactable_activated.connect(on_interactable_activated)
	manual_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	label.visible = false
	var timer := Timer.new()
	add_child(timer)
	
	timer.wait_time = randi_range(10, 50)
	timer.timeout.connect(on_timer_timeout)
	timer.start()

func on_interactable_activated() -> void:
	print("sink_activated")
	WaterManager.water_consumer_nums += 1

func on_interactable_deactivated() -> void:
	print("sink_deactivated")
	WaterManager.water_consumer_nums -= 1

func on_timer_timeout() -> void:
	need_repair = true
	label.visible = true
	WaterManager.water_consumer_nums += 1
	print("need repairs")

func _unhandled_input(event: InputEvent) -> void:
	if manual_interactable_component.is_player_nearby and Input.is_action_just_pressed("repair") and need_repair:
		if InventoryManager.inventory.get("log", 0) >= 2 and InventoryManager.inventory.get("stone", 0) >= 1:
			need_repair = false
			label.visible = false
			WaterManager.water_consumer_nums -= 1
			InventoryManager.inventory["log"] -= 2
			InventoryManager.inventory["stone"] -= 1
			InventoryManager.inventory_changed.emit()
			print("repaired")

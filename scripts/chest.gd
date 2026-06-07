extends Node2D

var balloon_scene = preload("res://dialogue/game_dialogue_balloon.tscn")

var corn_harvest_scene = preload("res://scenes/objects/plants/corn/corn_harvest.tscn")
var tomato_harvest_scene = preload("res://scenes/objects/plants/tomato/tomato_harvest.tscn")

@export var dialogue_start_command: String
@export var food_drop_height: int = 40
@export var days_until_produce: int
@export var animal_group: Node2D

@onready var auto_interactable_component: AutoInteractableComponent = $AutoInteractableComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var feed_component: FeedComponent = $FeedComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool
var is_chest_open: bool

var starting_day: int = 0
var food_storage: int = 0

class ChestState:
	var food_storage: int
	var animated_sprite: AnimatedSprite2D
	var interactable_label_component: Control

var dialogue_variables = ChestState.new()

func _ready() -> void:
	dialogue_variables.animated_sprite = animated_sprite_2d
	dialogue_variables.interactable_label_component = interactable_label_component
	auto_interactable_component.interactable_activated.connect(on_interactable_activated)
	auto_interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()
	
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	feed_component.food_received.connect(on_food_received)
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true

func on_interactable_deactivated() -> void:
	if is_chest_open and animated_sprite_2d.animation == "chest_open":
		animated_sprite_2d.play("chest_close")
		is_chest_open = false
	interactable_label_component.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("interact"):
			interactable_label_component.hide()
			animated_sprite_2d.play("chest_open")
			is_chest_open = true
			
			dialogue_variables.food_storage = food_storage
			var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
			get_tree().root.add_child(balloon)
			balloon.start(load("res://dialogue/conversations/chest.dialogue"), dialogue_start_command, [dialogue_variables])

func on_feed_the_animals() -> void:
	if in_range:
		trigger_feed_harvest("corn", corn_harvest_scene)
		trigger_feed_harvest("tomato", tomato_harvest_scene)

func trigger_feed_harvest(inventory_item: String, scene: Resource) -> void:
	var inventory: Dictionary = InventoryManager.inventory
	if !inventory.has(inventory_item):
		return
	
	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count:
		var harvest_instance = scene.instantiate() as Node2D
		harvest_instance.get_node("CollectableComponent").collision_mask = 0
		harvest_instance.global_position = Vector2(global_position.x, global_position.y - food_drop_height)
		get_tree().root.add_child(harvest_instance)
		var target_position = global_position
		
		var time_delay = randf_range(0.5, 2.0)
		await get_tree().create_timer(time_delay).timeout
		
		var tween = get_tree().create_tween()
		tween.tween_property(harvest_instance, "position", target_position, 1.0)
		tween.tween_property(harvest_instance, "scale", Vector2(0.5, 0.5), 1.0)
		tween.tween_callback(harvest_instance.queue_free)
		
		InventoryManager.remove_collectable(inventory_item)

func on_food_received() -> void:
	food_storage += 1

func on_time_tick_day(day: int) -> void:
	if starting_day == 0:
		starting_day = day
	
	var days_passed = day - starting_day
	if days_passed == days_until_produce:
		for animal_index in animal_group.get_child_count():
			if food_storage > 0 and animal_index < animal_group.get_child_count() - 1:
				animal_group.get_child(animal_index).add_reward()
				food_storage -= 1
		
		if food_storage > 0:
			starting_day = day

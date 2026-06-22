extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var wheat_label: Label = $MarginContainer/VBoxContainer/Wheat/WheatLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/Tomato/TomatoLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel
@onready var milk_label: Label = $MarginContainer/VBoxContainer/Milk/MilkLabel
@onready var wheat_seed_label: Label = $MarginContainer/VBoxContainer/WheatSeed/WheatSeedLabel
@onready var tomato_seed_label: Label = $MarginContainer/VBoxContainer/TomatoSeed/TomatoSeedLabel

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = str(inventory["log"])
	if inventory.has("stone"):
		stone_label.text = str(inventory["stone"])
	if inventory.has("wheat"):
		wheat_label.text = str(inventory["wheat"])
	if inventory.has("tomato"):
		tomato_label.text = str(inventory["tomato"])
	if inventory.has("egg"):
		egg_label.text = str(inventory["egg"])
	if inventory.has("milk"):
		milk_label.text = str(inventory["milk"])
	if inventory.has("wheat seed"):
		wheat_seed_label.text = str(inventory["wheat seed"])
	if inventory.has("tomato seed"):
		tomato_seed_label.text = str(inventory["tomato seed"])

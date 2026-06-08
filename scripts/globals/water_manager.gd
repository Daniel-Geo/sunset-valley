extends Node

var base_water_value: int = 10
var water_value: int
signal water_changed

func _ready() -> void:
	water_value = base_water_value

func refill_water() -> void:
	water_value = base_water_value
	water_changed.emit()

func add_water(amount: int) -> void:
	water_value += amount
	water_changed.emit()

func remove_water(amount: int) -> void:
	water_value -= amount
	water_changed.emit()

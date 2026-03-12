extends Node

var water_value: int = 100
var water_leakage: int = 1
var water_consumer_nums: int = 0

func _ready() -> void:
	var timer := Timer.new()
	add_child(timer)
	
	timer.wait_time = 1.0
	timer.timeout.connect(on_timer_timeout)
	timer.start()

func on_timer_timeout() -> void:
	if water_consumer_nums > 0:
		water_value -= water_leakage * water_consumer_nums

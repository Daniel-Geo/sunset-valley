extends Node

var water_value: int = 100
var water_leakage: int = 1
var water_consumer_nums: int = 0
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	add_child(timer)
	
	timer.wait_time = 1.0
	timer.timeout.connect(on_timer_timeout)

func _process(delta: float) -> void:
	if water_value <= 0:
		GameManager.show_game_over_screen()
		water_value = 100
		timer.stop()

func on_timer_timeout() -> void:
	if water_consumer_nums > 0:
		water_value -= water_leakage * water_consumer_nums

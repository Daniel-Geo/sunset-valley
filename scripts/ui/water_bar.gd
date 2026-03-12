extends TextureProgressBar


func _process(delta: float) -> void:
	value = WaterManager.water_value

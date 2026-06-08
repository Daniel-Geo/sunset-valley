extends TextureProgressBar


func _ready() -> void:
	value = WaterManager.base_water_value
	WaterManager.water_changed.connect(on_water_changed)

func on_water_changed() -> void:
	value = WaterManager.water_value

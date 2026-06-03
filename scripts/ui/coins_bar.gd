extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0
	CoinsManager.coins_changed.connect(on_coins_changed)

func on_coins_changed() -> void:
	value = CoinsManager.coins

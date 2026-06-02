extends PanelContainer

@onready var coin_label: Label = $MarginContainer/Coins/CoinLabel

func _ready() -> void:
	CoinsManager.coins_changed.connect(on_coins_changed)

func on_coins_changed() -> void:
	coin_label.text = str(CoinsManager.coins)

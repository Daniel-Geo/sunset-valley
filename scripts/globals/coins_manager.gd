extends Node

var coins: int = 0
signal coins_changed

func add_coins(ammount: int) -> void:
	coins += ammount
	coins_changed.emit()

func remove_coins(ammount: int) -> void:
	coins -= ammount
	coins_changed.emit()

func reset_coins() -> void:
	coins = 0
	coins_changed.emit()

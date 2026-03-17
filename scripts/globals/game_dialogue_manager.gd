extends Node

signal give_crop_seeds

func action_give_crop_seeds() -> void:
	give_crop_seeds.emit()

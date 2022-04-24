extends StaticBody2D
class_name Flower

export (float) var MAX_POLLEN:float = 60 
export (float) var POLLEN_REGEN_RATE:float = 1

onready var current_pollen:float = MAX_POLLEN

func _physics_process(delta):
	if current_pollen != MAX_POLLEN:
		++current_pollen

func get_pollen(quantity:float):
	if quantity <= current_pollen:
		current_pollen = current_pollen - quantity
		return quantity
	else:
		return current_pollen

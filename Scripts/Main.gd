extends Node2D

export (PackedScene) var ant_scene

onready var spawn_location = $Garden_Screen/Spawn_Location

func _ready():
	pass
	
func _on_Honey_attract_ant(to_position):
	var ant = ant_scene.instance()
	add_child(ant)
	spawn_location.unit_offset = randf()
	ant.position = spawn_location.position
	ant.target = to_position

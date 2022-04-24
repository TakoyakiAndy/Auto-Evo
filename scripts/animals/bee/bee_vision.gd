extends Area2D

var is_flower_near:bool = false
var flower:Flower = null


func _on_Vision_body_entered(body):
	if body is Flower:
		is_flower_near = true
		flower = body
		print("flower found!")

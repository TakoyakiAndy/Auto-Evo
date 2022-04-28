extends Area2D

var is_flower_near:bool = false
var current_flower:Flower = null

var flower_pool:Array

# create a stack of interactable bodies (not only flowers)
# this way you can pool objects as they are detected

func _on_Vision_body_entered(body):
	pass


func _on_Vision_body_exited(body):
	pass # Replace with function body.

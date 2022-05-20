extends Area2D

# create a stack of interactable bodies (not only flowers)
# this way you can pool objects as they are detected

func _on_Vision_body_entered(body):
	if body is Flower:
		get_parent().behavior_tree.blackboard.set("is_flower_near", true)
		get_parent().behavior_tree.blackboard.set("flower", body)


func _on_Vision_body_exited(body):
	if body is Flower:
		get_parent().behavior_tree.blackboard.set("is_flower_near", false)
		get_parent().behavior_tree.blackboard.erase("flower", body)

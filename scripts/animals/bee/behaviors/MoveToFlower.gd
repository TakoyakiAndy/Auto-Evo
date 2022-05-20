extends Action


func run():
	var distance = actor.position.direction_to(tree.blackboard.get("flower"))
	var velocity
	
	if distance > 2:
		velocity = distance * actor.SPEED
		actor.move_and_slide(velocity)
		running()
	else:
		success()

	

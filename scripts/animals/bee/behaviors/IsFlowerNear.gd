extends Condition

func run():
	if tree.blackboard.get("is_flower_near"):
		success()
	else:
		fail()

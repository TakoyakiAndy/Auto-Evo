extends Leaf

# same as leaf, but for checking conditions
class_name Condition, "res://scripts/behavior_tree/icons/condition.svg"

func _ready():
	pass

func run():
	if !actor.has_method(task_name):
		print("Function does not exist!")
		cancel()
	else:
		if actor.call(task_name):
			success()
		else:
			fail()

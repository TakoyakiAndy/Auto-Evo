extends Leaf

class_name Action, "res://scripts/behavior_tree/icons/action.svg"

# override 
func _ready():
	pass

func run():
	if !actor.has_method(task_name):
		print("Function does not exist!")
		cancel()
	else:
		actor.call(task_name)

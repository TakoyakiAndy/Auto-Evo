extends Decorator

# Only reports a success

class_name UntilSuccess, "res://scripts/behavior_tree/icons/category_decorator.svg"

func run():
	get_child(0).run()
	running()

func child_success():
	success()

# Ignore child failure
func child_fail():
	pass

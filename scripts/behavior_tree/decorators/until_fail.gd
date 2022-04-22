extends Decorator

# Only reports a failure

class_name UntilFail, "res://scripts/behavior_tree/icons/category_decorator.svg"

func run():
	get_child(0).run()
	running()

# Ignore child success
func child_success():
	pass

func child_fail():
	success()

extends Decorator

class_name Succeed, "res://scripts/behavior_tree/icons/succeed.svg"

func run():
	if get_child_count() > 0:
		get_child(0).run()
	success()

# Ignore child failure
func child_fail():
	pass

# Ignore child success
func child_success():
	pass

extends Decorator

class_name Fail, "res://scripts/behavior_tree/icons/fail.svg"

func run():
	if get_child_count() > 0:
		get_child(0).run()
	fail()

# Ignore child success
func child_success():
	pass

# Ignore child failure
func child_fail():
	pass

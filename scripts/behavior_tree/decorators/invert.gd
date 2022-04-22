extends Decorator

# Invert the result

class_name Invert, "res://scripts/behavior_tree/icons/inverter.svg"

func run():
	get_child(0).run()
	running()

func child_success():
	fail()

func child_fail():
	success()

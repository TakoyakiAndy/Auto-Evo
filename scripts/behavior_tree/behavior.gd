extends Node

class_name Behavior, "res://scripts/behavior_tree/icons/category_bt.svg"

"""
terminology from the Java:
	final (don’t change it). 
	abstract (put your own spin on it).
"""

# States
enum {
	FRESH,
	RUNNING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

var control = null
var tree = null
var actor = null
# var guard = null
var status = FRESH

# Final methods
func running():
	status = RUNNING
	if control != null:
		control.child_running()

func success():
	status = SUCCEEDED
	if control != null:
		control.child_success()

func fail():
	status = FAILED
	if control != null:
		control.child_fail()

func cancel():
	if status == RUNNING:
		status = CANCELLED
		# Cancel child tasks
		for child in get_children():
			child.cancel()

# Abstract methods
func run():
	# Process the task and call running(), success(), or fail()
	pass

func child_success():
	success()

func child_fail():
	fail()

func child_running():
	running()

# Non-final non-abstact methods
func start():
	status = FRESH
	for child in get_children():
		child.control = self
		child.tree = self.tree
		child.actor = self.actor
		child.start()

func reset():
	cancel()
	status = FRESH

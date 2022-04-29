extends Behavior

class_name RootBehavior, "icons/tree.svg"

const BLACKBOARD = preload("res://scripts/behavior_tree/blackboard.gd")

export (bool) var enabled = true

onready var blackboard = BLACKBOARD.new()

func _ready():
	tree = self
	actor = get_parent()
	print(actor)
	print(get_parent())
	start()
	status = RUNNING

func _physics_process(delta):
	if not enabled:
		return
	
	blackboard.set("delta", delta)


func enable():
	self.enabled = true

# if the root is not set up properly, use this function and print_debug an error
func disable():
	self.enabled = false

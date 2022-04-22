extends Node2D

var state = IS_HOLDED
var health = 5

signal attract_ant(to_position)

enum{
	IS_HOLDED,
	IS_PLACED
}

func _ready():
	#connect signal to the root node
	connect("attract_ant", get_parent(), "_on_Honey_attract_ant")
	
func _process(delta):
	match state:
		IS_HOLDED:
			is_holded_state()
		
func is_holded_state():
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		$AnimationPlayer.play("place")
		$Attract.start()
		state = IS_PLACED

func _on_Attract_timeout():
	var honey_position = position
	emit_signal("attract_ant", honey_position)

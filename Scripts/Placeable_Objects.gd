extends Node2D
class_name Placeable_Objects

var state = IS_HOLDED
var health = 0
var max_health = 0

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
	#destroy itself
	if health <= 0:
		queue_free()
		
func is_holded_state():
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		$AnimationPlayer.play("place")
		$Attract.start()
		state = IS_PLACED

func _on_Attract_timeout():
	pass

func _on_Ant_give_damage(damage):
	var _max_health = $Health.max_value
	#ficar visivel se for o primeiro hit
	if health == _max_health:
		$Health.visible = true
	#diminuir vida
	health -= damage
	$Health.value = health
	#mudar cor da barra de vida
	#50% life
	if $Health.value <= (_max_health / 2):
		$Health.tint_progress = Color(1, 1, 0, 1)
	#25% life
	if $Health.value <= (_max_health / 4):
		$Health.tint_progress = Color(1, 0, 0, 1)
	
	

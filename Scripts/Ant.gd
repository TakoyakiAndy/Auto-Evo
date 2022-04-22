extends KinematicBody2D

export (PackedScene) var anthill_scene

var speed = 20
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var state = FOOD_FOUND
var nest_position = Vector2.ZERO

signal give_damage(damage)
signal entering_nest

enum{
	FOOD_FOUND,
	EATING,
	BACKING_NEST,
	INSIDE_NEST
}

func _physics_process(delta):
	
	
	match state:
		FOOD_FOUND:
			food_found_state()
		BACKING_NEST:
			backing_nest_state()
		INSIDE_NEST:
			pass

func food_found_state():
	velocity = position.direction_to(target)
	velocity = move_and_slide(velocity * speed)

func _on_Area2D_body_entered(body):
	if body.is_in_group("food"):
		if state == FOOD_FOUND:
			state = EATING
			connect("give_damage", body, "_on_Ant_give_damage")
			$Eating.start()
	if body.name == "Anthill":
		if state == BACKING_NEST:
			state = INSIDE_NEST
			enter_nest()
		
func enter_nest():
	connect("entering_nest", get_parent().get_node("Anthill"), "_play_bounce_animation")
	emit_signal("entering_nest")
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	$AnimatedSprite.visible = false

func _on_Eating_timeout():
	var bite_damage = 2
	emit_signal("give_damage", bite_damage)
	yield(get_tree().create_timer(1.0),"timeout")
	
	if !get_parent().has_node("Anthill"):
		var anthill = anthill_scene.instance()
		get_parent().add_child(anthill)
		anthill.position = self.position
		get_nest_position()
		state = BACKING_NEST
	else:
		get_nest_position()
		state = BACKING_NEST

func get_nest_position():
	var nest = get_parent().get_node("Anthill").position
	nest_position = nest
	
func backing_nest_state():
	velocity = position.direction_to(nest_position)
	velocity = move_and_slide(velocity * speed)

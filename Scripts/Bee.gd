extends KinematicBody2D

var state = LOOKING_FLOWER
var speed = 50
var velocity = Vector2.ZERO
var flower_positon = Vector2.ZERO
var hive_position = Vector2.ZERO
var progress = 0

signal update_history(new_text)
signal give_honey(amount)
signal entering_nest

func _physics_process(delta):
	match state:
		LOOKING_FLOWER:
			looking_flower_state(delta)
		COLLECT_POLLEN:
			collect_pollen_state(delta)
		BACKING_TO_HIVE:
			backing_to_hive_state(delta)
		MAKING_HONEY:
			making_honey_state(delta)
	
	#other things
	$ProgressBar.value = progress
	
enum {
	LOOKING_FLOWER,
	COLLECT_POLLEN,
	BACKING_TO_HIVE,
	MAKING_HONEY
}
 
func looking_flower_state(delta):
	move_and_slide(Vector2.LEFT * speed)

func _on_Vision_body_entered(body):
	if state == LOOKING_FLOWER:
		if body.is_in_group("flowers"):
			var event =  "The bee found a flower"
			emit_signal("update_history", event)
			flower_positon = body.global_position
			state = COLLECT_POLLEN

func collect_pollen_state(delta):
	var distance = 1
	if position.distance_to(flower_positon) > distance:
		velocity = position.direction_to(flower_positon) * speed
		move_and_slide(velocity)
#		print(position.distance_to(flower_positon))
	else:
		var event =  "The bee is collecting pollen"
		emit_signal("update_history", event)
		$AnimationPlayer.play("RESET")
		$ProgressBar.value = progress
		$ProgressBar.visible = true
		progress += min(0.5, $ProgressBar.max_value)
		#$AnimationPlayer.playback_speed = 0
		
		if progress >= $ProgressBar.max_value:
			#$AnimationPlayer.playback_speed = 1
			#$AnimationPlayer.play("weggle")
			state = BACKING_TO_HIVE
		
func backing_to_hive_state(delta):
	#se encontrar uma coméia pra voltar
	if get_parent().has_node("Honeycomb"):
		var honeycomb = get_parent().get_node("Honeycomb")
		hive_position = honeycomb.position
		velocity = position.direction_to(hive_position) * speed
		move_and_slide(velocity)
		
		if $ProgressBar.visible:
			$ProgressBar.visible = false
			var event = "The bee is backing to the hive"
			emit_signal("update_history", event)

func _on_Colision_body_entered(body):
	if state == BACKING_TO_HIVE:
		if body.is_in_group("Hive"):
			progress = 0
			$Sprite.visible = false
			$ProgressBar.visible = true
			var event = "The bee is making honey"
			emit_signal("update_history", event)
			connect("entering_nest", get_parent().get_node("Honeycomb"), "_play_bounce_animation")
			emit_signal("entering_nest")
			state = MAKING_HONEY
		
func making_honey_state(delta):
	$ProgressBar.visible = true
	progress += min(0.5, $ProgressBar.max_value)
	
	if progress >= $ProgressBar.max_value:
		$ProgressBar.visible = false
		$Sprite.visible = true
		progress = 0
		var event = "The bee is looking for a flower"
		emit_signal("update_history", event)
		var honey_amount = 1
		emit_signal("give_honey", honey_amount)
		$Vision.monitoring = false
		state = LOOKING_FLOWER
		$Vision.monitoring = true

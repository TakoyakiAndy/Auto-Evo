extends StaticBody2D
class_name Nests

var food_supply = 0

func _play_bounce_animation():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("cresce_murcha")

extends Sprite

func _on_AnimationPlayer_animation_finished(Default):
	queue_free()

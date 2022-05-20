extends Action

func run():
	print("gay")
	actor.velocity = Vector2.LEFT * actor.SPEED
	actor.move_and_slide(actor.velocity)
	running()

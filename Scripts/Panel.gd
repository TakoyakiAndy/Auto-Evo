extends Panel

var honey_amount = 10
export (PackedScene) var honey_scene
export (PackedScene) var click_effect
var state = null

signal place_object

enum{
	HOLDING_SOMETHING
}

func  _physics_process(delta):
	$honey_btn.text = "Honey: " + str(honey_amount)
	
	match state:
		HOLDING_SOMETHING:
			holding_something_state()


func _on_Bee_give_honey(amount):
	honey_amount += amount

func holding_something_state():
	pass
	
func _on_honey_btn_pressed():
	if honey_amount > 0:
		var amount = 1
		honey_amount -= amount
		var honey = honey_scene.instance()
		owner.add_child(honey)
		click_effect()
		state = HOLDING_SOMETHING

func click_effect():
	var click_fx = click_effect.instance()
	owner.add_child(click_fx)
	click_fx.position = get_global_mouse_position()
	

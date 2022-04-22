extends Placeable_Objects

func _ready():
	max_health = 10
	health = max_health
	$Health.max_value = max_health
	$Health.value = max_health

func _on_Attract_timeout():
	var honey_position = position
	emit_signal("attract_ant", honey_position)

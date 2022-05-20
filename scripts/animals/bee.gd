extends Insect

class_name Bee

export (float) var MAX_HEALTH:float = 50
export (float) var MAX_ENERGY:float = 50
export (float) var MAX_POLLEN:float = 50
export (float) var SPEED:float		= 50

var hive = null

var velocity

onready var current_health:float = MAX_HEALTH
onready var current_energy:float = MAX_ENERGY
onready var current_pollen:float = MAX_POLLEN

onready var behavior_tree = $RootBehavior

func ready():
	behavior_tree.run()

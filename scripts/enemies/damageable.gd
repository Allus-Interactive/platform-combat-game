extends Node

class_name Damageable

@export var health : int = 20 : 
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int):
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()


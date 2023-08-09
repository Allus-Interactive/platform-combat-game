extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : int)

@export var dead_animation : String = "dead"
@export var health : int = 20 : 
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int):
	health -= damage
	
	emit_signal("on_hit", get_parent(), damage)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == dead_animation):
		# enemy is dead, remove from scene
		get_parent().queue_free()

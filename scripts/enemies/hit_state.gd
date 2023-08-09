extends PlayerState

class_name HitState

@export var damageable : Damageable
@export var dead_state : PlayerState
@export var dead_animation : String = "dead"

func _ready():
	damageable.connect("on_hit", on_damagable_hit)

func on_damagable_hit(node : Node, damage_amount : int):
	if damageable.health > 0:
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)


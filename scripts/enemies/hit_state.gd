extends PlayerState

class_name HitState

@export var damageable : Damageable
@export var dead_state : PlayerState
@export var return_state : PlayerState
@export var dead_animation : String = "dead"
@export var knockback_velocity : Vector2 = Vector2(100, 0)

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damagable_hit)

func on_enter():
	character.velocity = knockback_velocity
	timer.start()

func on_damagable_hit(_node : Node, _damage_amount : int):
	if damageable.health > 0:
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state

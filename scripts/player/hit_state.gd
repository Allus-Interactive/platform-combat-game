extends State

class_name PlayerHitState

@export var damageable : PlayerDamageable
@export var dead_state : State
@export var return_state : State
@export var knockback_speed : float = 100.0

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_player_hit", on_damagable_hit)

func on_enter():
	timer.start()

func on_damagable_hit(_node : Node, _damage_amount : int, knockback_direction : Vector2):
	if damageable.health > 0:
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
		playback.travel("hurt")
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel("dead")

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	next_state = return_state

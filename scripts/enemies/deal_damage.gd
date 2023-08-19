extends Area2D

@export var damage : int = 5
@export var dead_state : State

@onready var state_machine : CharacterStateMachine = $"../CharacterStateMachine"

# deals damage to player when enemy and player collide
func _on_body_entered(body):
	for child in body.get_children():
		if child is PlayerDamageable && state_machine.current_state != dead_state:
			child.hit(damage, Vector2.LEFT)

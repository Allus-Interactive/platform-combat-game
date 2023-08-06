extends PlayerState

class_name GroundState

@export var jump_velocity : float = -150.0
@export var air_state : PlayerState

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state

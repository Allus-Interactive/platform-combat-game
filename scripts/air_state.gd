extends PlayerState

class_name Airstate

@export var ground_state : PlayerState
@export var double_jump_velocity : float = -100.0

var has_double_jumped : bool = false

func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump") && not has_double_jumped:
		double_jump()

func on_exit():
	if next_state == ground_state:
		has_double_jumped = false

func double_jump():
	# Set y velocity to double jump
	character.velocity.y = double_jump_velocity
	# Set bool to avoid endless double jumps
	has_double_jumped = true

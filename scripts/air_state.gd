extends PlayerState

class_name Airstate

@export var ground_state : PlayerState
@export var double_jump_velocity : float = -150.0
@export var double_jump_animation : String = "double_jump"

var has_double_jumped : bool = false

func state_process(_delta):
	if character.is_on_floor():
		next_state = ground_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump") && not has_double_jumped:
		double_jump()

func on_exit():
	if next_state == ground_state:
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true

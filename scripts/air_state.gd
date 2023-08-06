extends PlayerState

class_name Airstate

@export var landing_state : PlayerState
@export var double_jump_velocity : float = -150.0
@export var double_jump_animation : String = "double_jump"
@export var mid_jump_animation : String = "jump_middle"
@export var end_jump_animation : String = "jump_end"
@export var landing_animation : String = "landing"

var has_double_jumped : bool = false

var is_at_jump_peak : bool = false
var is_falling : bool = false

func state_process(_delta):
	if character.is_on_floor():
		next_state = landing_state
		is_at_jump_peak = false
		is_falling = false
	else:
		handle_jump_animations()

func state_input(event : InputEvent):
	if event.is_action_pressed("jump") && not has_double_jumped:
		is_at_jump_peak = false
		is_falling = false
		double_jump()

func on_exit():
	if next_state == landing_state:
		playback.travel(landing_animation)
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true

func handle_jump_animations():
	if character.velocity.y > -25 && character.velocity.y < 25 && not is_at_jump_peak:
		# Player is at peak of jump
		print_debug("mid jump")
		playback.travel(mid_jump_animation)
		is_at_jump_peak = true
	
	if character.velocity.y > 25 && not is_falling:
		# Player is falling
		print_debug("end jump")
		playback.travel(end_jump_animation)
		is_falling = true


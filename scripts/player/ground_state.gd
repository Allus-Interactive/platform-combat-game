extends State

class_name GroundState

@export var jump_velocity : float = -200.0
@export var roll_speed : float = 400.0
@export var air_state : State
@export var roll_state : State
@export var attack_state : State
@export var jump_animation : String = "jump_start"
@export var roll_animation : String = "roll"
@export var attack_animation : String = "attack_1"

@onready var buffer_timer : Timer = $BufferTimer

var is_facing_right : bool = true

func state_process(_delta):
	# check direction of player for roll velocity
	if character.direction.x < 0:
		is_facing_right = false
	elif character.direction.x > 0:
		is_facing_right = true
	
	if not character.is_on_floor() && buffer_timer.is_stopped():
		next_state = air_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("roll"):
		roll()
	if event.is_action_pressed("attack"):
		attack()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func roll():
	roll_state.is_rolling = true
	if is_facing_right:
		character.velocity.x = roll_speed
	else:
		character.velocity.x = -roll_speed
	next_state = roll_state
	playback.travel(roll_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)


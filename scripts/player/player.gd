extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export var hit_state : State

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var fallen_timer: Timer = $FallenTimer

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var fallen_off_screen : bool = false;

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	# can only move if player hasn't fallen off the screen
	if not fallen_off_screen:
		if direction.x != 0 && state_machine.check_if_can_move():
			velocity.x = direction.x * speed
		elif state_machine.check_if_is_rolling():
			pass # do nothing, velocity is controlled in the roll function
		elif state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, speed)
	
	if position.y > 300 && not fallen_off_screen:
		fallen_off_screen = true
		fallen_timer.start()
	
	move_and_slide()
	update_animation_parameters()
	update_direction()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_fallen_timer_timeout():
	get_tree().reload_current_scene()

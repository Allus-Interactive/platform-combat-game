extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float = -150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var is_at_jump_peak : bool = false
var is_falling : bool = false

var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
		was_in_air = true
	else:
		# Land on the ground
		if was_in_air:
			land()
		# Reset bools
		has_double_jumped = false
		was_in_air = false
		is_at_jump_peak = false
		is_falling = false
	
	# Handle Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal Jump
			jump()
		elif not has_double_jumped:
			# Double Jump
			velocity.y = double_jump_velocity
			has_double_jumped = true
	
	# Handle jump animations
	if not is_on_floor():
		if velocity.y > -25 && velocity.y < 25 && not is_at_jump_peak:
			animated_sprite.play("jump_middle")
			is_at_jump_peak = true
		
		if velocity.y > 25 && not is_falling:
			animated_sprite.play("jump_end")
			is_falling = true
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && animated_sprite.animation != "jump_land":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_direction()

func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

func update_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true

func land():
	animated_sprite.play("jump_land")
	animation_locked = true

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "jump_land":
		animation_locked = false

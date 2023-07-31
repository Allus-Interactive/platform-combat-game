extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float = -150.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_double_jumped : bool = false

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
	else:
		# Reset double jump bool
		has_double_jumped = false

	# Handle Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal Jump
			velocity.y = jump_velocity
		elif not has_double_jumped:
			# Double Jump
			velocity.y = double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration
	# As good practice, you should replace UI actions with custom gameplay actions
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Set direction to the starting move direction vector
	var direction : Vector2 = starting_move_direction
	if direction:
		velocity.x = direction.x * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()

extends CharacterBody2D

@export var speed : float = 200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	elif state_machine.check_if_is_rolling():
		pass # do nothing, velocity is controlled in the roll function
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
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

extends CharacterBody2D

@export var speed : float = 200.0
@export var roll_speed : float = 300.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_double_jumped : bool = false
var animation_locked : bool = false
var was_in_air : bool = false
var is_at_jump_peak : bool = false
var is_falling : bool = false
var is_facing_right : bool = true
var has_weapon : bool = false

func _ready():
	animation_tree.active = true

var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	if not is_on_floor():
		# Add the gravity
		velocity.y += gravity * delta
		# Player is in the air
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
	
	# Handle jump animations
	if not is_on_floor():
		if velocity.y > -25 && velocity.y < 25 && not is_at_jump_peak:
			# Player is at peak of jump
			#animated_sprite.play("jump_middle")
			animation_locked = true
			is_at_jump_peak = true
		
		if velocity.y > 25 && not is_falling:
			# Player is falling
			#animated_sprite.play("jump_end")
			animation_locked = true
			is_falling = true
	
	# Handle Roll
	if Input.is_action_just_pressed("roll") && is_on_floor() && not has_weapon:
		roll()
	
	# Handle Weapon Toggle
	#if Input.is_action_just_pressed("toggle_weapon") && animated_sprite.animation != "roll":
	#	toggle_weapon()
	
	# Get the input direction and handle the movement/deceleration
	direction = Input.get_vector("move_left", "move_right", "ui_up", "ui_down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	#elif animated_sprite.animation == "roll":
		#pass
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_direction()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_direction():
	if direction.x > 0:
		# Player facing right
		is_facing_right = true
		sprite.flip_h = false
	elif direction.x < 0:
		# Player facing left
		is_facing_right = false
		sprite.flip_h = true

func land():
	#animated_sprite.play("jump_land")
	animation_locked = true

func roll():
	# Play roll anim and lock anims
	#animated_sprite.play("roll")
	animation_locked = true
	# Set velocity based on direction player is facing
	if is_facing_right:
		velocity.x = roll_speed
	else:
		velocity.x = -roll_speed

func toggle_weapon():
	if has_weapon:
		has_weapon = false
	else:
		has_weapon= true

#func _on_animated_sprite_2d_animation_finished():
#	# Call when any anim finishes
#	if animated_sprite.animation == "jump_land":
#		# Only run this when jump land anim is finished
#		animation_locked = false
#
#	if animated_sprite.animation == "roll":
#		# Only run this when roll anim is finished
#		animation_locked = false


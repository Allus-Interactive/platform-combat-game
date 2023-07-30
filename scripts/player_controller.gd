extends CharacterBody2D

var speed = 200
var jump_speed = 200
var gravity = 400

func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_speed
	# gravity
	velocity.y += gravity * delta
	move_and_slide()

func _physics_process(delta):
	get_input(delta)

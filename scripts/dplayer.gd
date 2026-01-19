extends CharacterBody2D

@export var speed = 700
@export var gravity = 30
# up direction on y-axis is neg
@export var jump_force = -300

func _physics_process(delta):
	# returns bool from player's pos
	if !is_on_floor():
		# apply each frame player isn't on floor
		velocity.y += gravity
		if velocity.y > 500: #cap
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_force

	# horizontal movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
	print(velocity)

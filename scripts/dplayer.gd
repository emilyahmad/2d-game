extends CharacterBody2D

func _physics_process(delta):
	velocity.x = 300
	move_and_slide()

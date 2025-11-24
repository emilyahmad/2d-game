extends Area2D

signal fish_collected

@export var speed = 200
var screen_size

func _on_body_entered(body):
	fish_collected.emit()
	body.queue_free()
	$Crunch.play()

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("p2_move_right"):
		velocity.x += 1
	if Input.is_action_pressed("p2_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("p2_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("p2_move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

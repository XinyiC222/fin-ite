extends CharacterBody2D

@export var speed = 150.0
var current_size = 1.0
var change_direction_timer = 0.0

func _ready():
	# Spawn near the center so you can see them
	var camera = get_viewport().get_camera_2d()
	if camera:
		position = camera.position + Vector2(randf_range(-400, 400), randf_range(-300, 300))
	else:
		position = Vector2(960, 540)
		
	var random_angle = randf_range(0, TAU)
	velocity = Vector2(cos(random_angle), sin(random_angle)) * speed
	scale = Vector2(current_size, current_size)

func _physics_process(delta):
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		var random_angle = randf_range(0, TAU)
		velocity = Vector2(cos(random_angle), sin(random_angle)) * speed
		change_direction_timer = randf_range(1.0, 3.0)

	move_and_slide()

	# Bounce off walls
	var screen_size = get_viewport_rect().size
	if position.x < 0 or position.x > screen_size.x:
		velocity.x *= -1
		position.x = clamp(position.x, 0, screen_size.x)
	if position.y < 0 or position.y > screen_size.y:
		velocity.y *= -1
		position.y = clamp(position.y, 0, screen_size.y)

	# Animation (No rotation, just flipping)
	var move_dir = velocity.normalized()
	if move_dir != Vector2.ZERO:
		$Sprite2D.rotation = 0.0 
		if move_dir.x < 0: $Sprite2D.flip_h = true
		else: $Sprite2D.flip_h = false

	scale = Vector2(current_size, current_size)

func get_eaten():
	queue_free()

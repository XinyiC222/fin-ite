extends Area2D

@export var speed = 220.0
@export var fixed_size: float = 2.5

var current_size: float:
	get: return fixed_size
	set(val): pass

var direction = 1.0

func _ready():
	var screen_size = get_viewport_rect().size
	if randf() > 0.5:
		position = Vector2(-150, randf_range(50, screen_size.y - 50))
		direction = 1.0
		$Sprite2D.flip_h = false
	else:
		position = Vector2(screen_size.x + 150, randf_range(50, screen_size.y - 50))
		direction = -1.0
		$Sprite2D.flip_h = true
	scale = Vector2(fixed_size, fixed_size)

func _physics_process(delta):
	position.x += speed * direction * delta
	var screen_size = get_viewport_rect().size
	if (direction == 1.0 and position.x > screen_size.x + 150) or \
	   (direction == -1.0 and position.x < -150):
		queue_free()

func get_eaten():
	queue_free()

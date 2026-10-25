extends Area2D

@export var speed = 400.0
var current_size = 1.0


@export var ui_node: Node 

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	position += input_dir * speed * delta

	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if input_dir != Vector2.ZERO:
		$Sprite2D.rotation = 0.0 
		if input_dir.x < 0: $Sprite2D.flip_h = true
		else: $Sprite2D.flip_h = false

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		if current_size > area.current_size:
			area.call_deferred("queue_free")
			grow(0.1)
		else:
			# Game Over
			set_physics_process(false) # Stop player movement
			if ui_node:
				ui_node.show_game_over()

func grow(amount):
	current_size += amount
	scale = Vector2(current_size, current_size)
	if ui_node:
		ui_node.update_size_display(current_size)

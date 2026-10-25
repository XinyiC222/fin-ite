extends Node2D

@export var fish_scene: PackedScene
@export var shark_scene: PackedScene

func _ready():
	# Make sure the timer doesn't start until Play is clicked
	$Timer.paused = true

func _on_timer_timeout():
	var spawn_shark = randf() <= 0.2
	var scene_to_spawn = shark_scene if spawn_shark else fish_scene
	
	if scene_to_spawn == null:
		print("ERROR: Drag scenes into Spawner Inspector!")
		return
		
	var new_enemy = scene_to_spawn.instantiate()
	
	if not spawn_shark:
		new_enemy.current_size = randf_range(0.5, 2.2)
		
	add_child(new_enemy)

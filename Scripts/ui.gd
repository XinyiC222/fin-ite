extends CanvasLayer

@export var start_screen: Node
@export var game_over_screen: Node
@export var size_label: Node
@export var spawner_node: Node
@export var play_button: Node # DRAG YOUR PLAY BUTTON HERE
@export var reset_button: Node # DRAG YOUR RESET BUTTON HERE

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if game_over_screen: game_over_screen.visible = false
	if start_screen: start_screen.visible = true
	
	if play_button: play_button.visible = true
	if reset_button: reset_button.visible = false # Hidden at start
	 
	get_tree().paused = true

func _on_play_button_pressed():
	print("PLAY BUTTON WORKING")
	
	if start_screen: start_screen.visible = false
	if game_over_screen: game_over_screen.visible = false
	
	if play_button: play_button.visible = false
	if reset_button: reset_button.visible = true # Show reset during gameplay
	 
	get_tree().paused = false
	
	if spawner_node and spawner_node.has_node("Timer"):
		spawner_node.get_node("Timer").paused = false
		


func _on_restart_button_pressed():
	print("RESET WAS CLICKED!") # <--- ADD THIS
	get_tree().paused = false
	get_tree().reload_current_scene()

func show_game_over():
	if game_over_screen:
		game_over_screen.visible = true
		
	if reset_button: reset_button.visible = true # Make sure reset is visible on death
	 
	get_tree().paused = true
func update_size_display(new_size):
	if size_label:
		size_label.text = "Size: " + str(snapped(new_size, 0.1))


func _on_reset_pressed() -> void:
	pass # Replace with function body.

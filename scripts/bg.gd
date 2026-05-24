extends Spatial

# Parallax scrolling speed for the background.
var speed = 3

var starting_pos

func _ready():
	starting_pos = global_transform.origin
	set_physics_process(false)
	
func start():
	$Timer.start()
	set_physics_process(true)
	
func _physics_process(delta):
	# Move the background leftward to create a sense of motion.
	global_transform.origin += delta * speed * Vector3.LEFT
	
func _on_Timer_timeout():
	# Reset the background position to its starting point to loop seamlessly.
	global_transform.origin = starting_pos

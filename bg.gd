extends Spatial

var speed = 3

var starting_pos

func _ready():
	starting_pos = global_transform.origin
	set_physics_process(false)
	
func start():
	$Timer.start()
	set_physics_process(true)
	
func _physics_process(delta):
	
	global_transform.origin += delta * speed * Vector3.LEFT
	
	
func _on_Timer_timeout():
	global_transform.origin = starting_pos
	pass # Replace with function body.

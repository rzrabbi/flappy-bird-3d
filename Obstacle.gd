extends Spatial


var speed = 10

func _physics_process(delta):
	
	global_transform.origin += delta * speed * Vector3.LEFT
	
	pass


func _on_DestroyTimer_timeout():
	
	queue_free()
	
	pass # Replace with function body.

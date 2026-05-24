extends Spatial

# Movement speed of the obstacle along the Z-axis (leftwards).
var speed = 10

func _physics_process(delta):
	# Continuously move the obstacle to simulate forward flight.
	global_transform.origin += delta * speed * Vector3.LEFT

func _on_DestroyTimer_timeout():
	# Free the obstacle from memory once it is safely out of view.
	queue_free()

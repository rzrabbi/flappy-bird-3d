extends RigidBody

var jump_power = 32

func _input(event):
	
	if event.is_action_pressed("Jump"):
		
		jump()
		pass
	pass
	
func jump():
	apply_central_impulse(jump_power * Vector3.UP)

func start():
	mode = RigidBody.MODE_RIGID
	
	
	

func _on_Bird_body_entered(body):
	
	#die
	mode = RigidBody.MODE_STATIC
	$"../Button2".show()
	
	get_tree().paused = true
	pass # Replace with function body.

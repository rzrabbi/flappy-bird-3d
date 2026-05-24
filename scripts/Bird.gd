extends RigidBody

# The upward impulse applied when the player jumps.
var jump_power = 32

func _input(event):
	# Handle jump input from the mapped action or direct screen taps/clicks.
	if event.is_action_pressed("Jump") || (event is InputEventMouseButton && event.pressed):
		jump()
	
func jump():
	apply_central_impulse(jump_power * Vector3.UP)

func start():
	# Enable physics simulation to let the bird fall.
	mode = RigidBody.MODE_RIGID

func _on_Bird_body_entered(body):
	# Handle game over state upon collision.
	mode = RigidBody.MODE_STATIC
	$"../Button2".show()
	get_tree().paused = true

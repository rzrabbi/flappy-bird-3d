extends RigidBody

# The upward impulse applied when the player jumps.
var jump_power = 32

func _unhandled_input(event):
	# Handle jump input from the mapped action or direct screen taps/clicks.
	if event.is_action_pressed("Jump") || (event is InputEventMouseButton && event.pressed):
		jump()
	
func jump():
	if mode == RigidBody.MODE_STATIC:
		return
	apply_central_impulse(jump_power * Vector3.UP)
	if has_node("../BirdJump"):
		$"../BirdJump".play()

func start():
	# Enable physics simulation to let the bird fall.
	mode = RigidBody.MODE_RIGID

func _on_Bird_body_entered(body):
	# Handle game over state upon collision.
	if get_tree().paused:
		return
	mode = RigidBody.MODE_STATIC
	$"../Button2".show()
	if has_node("../BirdCollision"):
		$"../BirdCollision".play()
	get_tree().paused = true
	
	if has_node("../GameOverBGM"):
		yield(get_tree().create_timer(3.0), "timeout")
		if is_instance_valid(get_tree()) and has_node("../GameOverBGM"):
			$"../GameOverBGM".play()

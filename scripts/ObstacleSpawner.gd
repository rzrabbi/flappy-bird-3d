extends Spatial

var obstacle = preload("res://scenes/Obstacle.tscn")

# The maximum vertical deviation for spawning obstacles.
var offset_y = 8.5

func start_spawning():
	# Spawn the first obstacle immediately and start the repeating timer.
	_on_SpawnDelay_timeout()
	$SpawnDelay.start()

func _on_SpawnDelay_timeout():
	# Instantiate and add a new obstacle to the scene.
	var spawned_obstacle = obstacle.instance()
	add_child(spawned_obstacle)
	
	# Randomize the vertical position within the defined offset range.
	spawned_obstacle.translate(rand_range(-offset_y, offset_y) * Vector3.UP)

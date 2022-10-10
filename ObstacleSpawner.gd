extends Spatial

var obstacle = preload("res://Obstacle.tscn")

var offset_y = 5.0

func start_spawning():
	_on_SpawnDelay_timeout()
	$SpawnDelay.start()
		


func _on_SpawnDelay_timeout():
	
	var spawned_obstacle = obstacle.instance()
	
	add_child(spawned_obstacle)
	
	spawned_obstacle.translate(rand_range(-offset_y, offset_y) * Vector3.UP)
	
	pass # Replace with function body.

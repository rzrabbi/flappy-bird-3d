extends Spatial



func _on_Button_pressed():
	$Button.hide()
	$Bird.start()
	$ObstacleSpawner.start_spawning()
	
	
	pass # Replace with function body.


func _on_Button2_pressed():
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	
	pass # Replace with function body.

extends Spatial



func _on_Button_pressed():
	$Button.hide()
	$Bird.start()
	
	
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.

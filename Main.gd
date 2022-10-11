extends Spatial

var score = 0
var hiscore = 0

func _ready():
	load_hiscore()
	
	$Score.text = "Score: 0\nHigh Score: " + String(hiscore)
	
func _exit_tree():
	save_hiscore()
	
func save_hiscore():
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_64(hiscore)
	file.close()

func load_hiscore():
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	var content = file.get_64()
	if content == null:
		content = 0
		
	hiscore = content
	file.close()
   

func _on_Button_pressed():
	$Button.hide()
	$Bird.start()
	$ObstacleSpawner.start_spawning()
	$AutoScoreTimer.start()
	
	
	pass # Replace with function body.


func _on_Button2_pressed():
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	
	pass # Replace with function body.


func _on_AutoScoreTImer_timeout():
	
	score += 1
	
	if score >= hiscore:
		hiscore = score
	
	$Score.text = "Score: " + String(score) + "\nHigh Score: " + String(hiscore)
	
	pass # Replace with function body.

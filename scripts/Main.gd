extends Spatial

var score = 0
var hiscore = 0

func _ready():
	load_hiscore()
	$Score.text = "Score: 0\nHigh Score: " + String(hiscore)
	
func _exit_tree():
	# Ensure the high score is saved when the game is closed or scene changes.
	save_hiscore()
	
func save_hiscore():
	# Persist the high score to user data using a binary file.
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	file.store_64(hiscore)
	file.close()

func load_hiscore():
	# Load the persisted high score from user data if it exists.
	var file = File.new()
	file.open("user://save_game.dat", File.READ)
	
	if file == null or not file.is_open():
		if file:
			file.close()
		return
		
	var content = file.get_64()
	if content == null:
		content = 0
		
	hiscore = content
	file.close()

func _on_Button_pressed():
	# Start the game loop: hide UI, enable player physics, start spawning obstacles.
	$Button.hide()
	$Bird.start()
	$ObstacleSpawner.start_spawning()
	$AutoScoreTimer.start()
	$bg.start()

func _on_Button2_pressed():
	# Restart the game by reloading the current scene and unpausing the tree.
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_AutoScoreTImer_timeout():
	# Increment score over time while the player is alive.
	score += 1
	
	if score >= hiscore:
		hiscore = score
	
	$Score.text = "Score: " + String(score) + "\nHigh Score: " + String(hiscore)

extends Spatial

var score = 0
var hiscore = 0

var main_menu_bgm: AudioStreamPlayer
var game_over_bgm: AudioStreamPlayer
var ui_button_click: AudioStreamPlayer
var bird_jump: AudioStreamPlayer
var bird_collision: AudioStreamPlayer

func create_audio(node_name: String, path: String) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	player.name = node_name
	player.stream = load(path)
	player.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(player)
	return player

func _ready():
	main_menu_bgm = create_audio("MainMenuBGM", "res://assets/sounds/main_menu_bgm.ogg")
	game_over_bgm = create_audio("GameOverBGM", "res://assets/sounds/game_over.ogg")
	ui_button_click = create_audio("UIButtonClick", "res://assets/sounds/ui_button_click.wav")
	bird_jump = create_audio("BirdJump", "res://assets/sounds/bird_jump.wav")
	bird_collision = create_audio("BirdCollision", "res://assets/sounds/bird_collision.wav")
	
	main_menu_bgm.play()

	load_hiscore()
	$Score.text = "Score: 0\nHigh Score: " + String(hiscore)
	
	var version_label = Label.new()
	version_label.text = "v" + str(ProjectSettings.get_setting("application/config/version"))
	
	var font = DynamicFont.new()
	font.font_data = load("res://assets/fonts/LilitaOne-Regular.ttf")
	font.size = 36
	font.outline_size = 3
	font.outline_color = Color(0.196, 0.643, 1)
	version_label.add_font_override("font", font)
	
	version_label.anchor_left = 1.0
	version_label.anchor_top = 1.0
	version_label.anchor_right = 1.0
	version_label.anchor_bottom = 1.0
	version_label.margin_left = -200
	version_label.margin_top = -60
	version_label.margin_right = -20
	version_label.margin_bottom = -20
	version_label.align = Label.ALIGN_RIGHT
	version_label.valign = Label.VALIGN_BOTTOM
	add_child(version_label)
	
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
	if is_instance_valid(ui_button_click):
		ui_button_click.play()
	if is_instance_valid(main_menu_bgm):
		main_menu_bgm.stop()
		
	$Button.hide()
	$Bird.start()
	$ObstacleSpawner.start_spawning()
	$AutoScoreTimer.start()
	$bg.start()

func _on_Button2_pressed():
	# Restart the game by reloading the current scene and unpausing the tree.
	if is_instance_valid(ui_button_click):
		ui_button_click.play()
		yield(ui_button_click, "finished")
		
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_AutoScoreTImer_timeout():
	# Increment score over time while the player is alive.
	score += 1
	
	if score >= hiscore:
		hiscore = score
	
	$Score.text = "Score: " + String(score) + "\nHigh Score: " + String(hiscore)

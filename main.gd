extends Node

@export var mob_scene: PackedScene
var score
var player2score
const TARGET_SCORE := 10
var multi = false

func game_over():
	$MobTimer.stop()
	_clear_all_mobs()

	$HUD.show_game_over()
	$Music.stop()
	$Winning.play()
	print("Game over called")

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$Player2.hide()
	
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_score(score)
	
	$HUD.show_message("Get Ready")
	_clear_all_mobs()
	#get_tree().call_group("mobs", "queue_free")
	$Music.play()

func new_multiplayer_game():
	multi = true
	score = 0
	player2score = 0
	$Player.start($StartPosition.position - Vector2(100, 0))
	$Player2.start($StartPosition.position + Vector2(100, 0))
	
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_score(score)
	
	$HUD.update_player2_score(player2score)
	$HUD.update_player2_score(player2score)
	
	$HUD.show_message("Get Ready")
	_clear_all_mobs()
	$Music.play()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	mob.add_to_group("mobs")
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI/2
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _clear_all_mobs():
	for mob in get_tree().get_nodes_in_group("mobs"):
		mob.queue_free()

func _on_start_timer_timeout():
	$MobTimer.start()

func _ready():
	$HUD.stop_music_pressed.connect(_on_stop_music_pressed)

func _on_stop_music_pressed():
	var master = AudioServer.get_bus_index("Master")
	var isMuted = AudioServer.is_bus_mute(master)
	AudioServer.set_bus_mute(master, !isMuted)

func _on_player_2_fish_collected():
	player2score += 1
	$HUD.update_player2_score(player2score)
	if player2score >= TARGET_SCORE:
		check_winner()
		multiplayer_game_over()
		$StartTimer.stop()

func _on_hud_start_multiplayer_game():
	new_multiplayer_game()

func _on_player_fish_collected():
		score += 1
		$HUD.update_score(score)
		if score >= TARGET_SCORE:
			if (multi == true):
				check_winner()
				multiplayer_game_over()
			else:
				game_over()
			$StartTimer.stop()

func check_winner():
	if score >= TARGET_SCORE and player2score >= TARGET_SCORE:
		$HUD._display_winner("Tie")
	elif score >= TARGET_SCORE:
		$HUD._display_winner("Player 1 wins!")
	elif player2score >= TARGET_SCORE:
		$HUD._display_winner("Player 2 wins!")

func multiplayer_game_over():
	$MobTimer.stop()
	_clear_all_mobs()

	$HUD.show_multiplayer_game_over()
	$Music.stop()
	$Winning.play()


#button to platformer (remove later)/just for testing
func _on_to_platform_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

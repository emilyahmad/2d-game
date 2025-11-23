extends Node

@export var mob_scene: PackedScene
var score
const TARGET_SCORE := 10

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
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	_clear_all_mobs()
	#get_tree().call_group("mobs", "queue_free")
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

func _on_start_timer_timeout() -> void:
	$MobTimer.start()

func _ready():
	pass

func _on_player_fish_collected() -> void:
	score += 1
	$HUD.update_score(score)
	if score >= TARGET_SCORE:
		game_over()
		$StartTimer.stop()

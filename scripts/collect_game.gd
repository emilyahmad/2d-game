extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func _on_player_hit() -> void:
	score += 1
	$HUDc.update_score(score)
	if score > 9:
		game_over()

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUDc.show_game_over()

func new_game():
	score = 0
	$HUDc.update_score(score)
	$HUDc.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()

extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUDa.show_game_over()
	get_tree().call_group("mobs", "set_visible", false)

func new_game():
	#get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUDa.update_score(score)
	$HUDa.show_message("Get Ready")
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
	var velocity = Vector2(randf_range(850.0, 950.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUDa.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

extends Node

@export var mob_scene: PackedScene

const TARGET_SCORE := 10
var score: int = 0


func _ready() -> void:
	new_game()


func new_game() -> void:
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

	_clear_all_mobs()

	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$StartTimer.stop()

	_clear_all_mobs() # <-- mobs disappear here

	$HUD.show_game_over()
	$Music.stop()
	$Winning.play()


func _clear_all_mobs() -> void:
	get_tree().call_group("mobs", "queue_free")


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout() -> void:
	if mob_scene == null:
		push_error("mob_scene is not assigned in the Inspector.")
		return

	var mob = mob_scene.instantiate()

	var spawn = $MobPath/MobSpawnLocation
	spawn.progress_ratio = randf()

	mob.position = spawn.position

	var direction = spawn.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	mob.add_to_group("mobs") # so we can delete them at game_over
	add_child(mob)


func _on_player_hit() -> void:
	score += 1
	$HUD.update_score(score)

	if score >= TARGET_SCORE:
		game_over()


func _on_hud_start_game() -> void:
	new_game()

extends Node

@export var mob_scene: PackedScene
var score := 0

func _ready():
	$Player.hit_mob.connect(_on_player_hit_mob)

func game_over() -> void:
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
	mob.add_to_group("mobs")

	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	mob.position = mob_spawn_location.position
	var direction = mob_spawn_location.rotation + PI / 2
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(600.0, 950.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()

func _on_player_hit_mob(mob: Variant) -> void:
	if score < 10:
		score += 1
		$HUDc.update_score(score)
		mob.queue_free()
	else:
		game_over()

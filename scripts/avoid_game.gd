extends Node

@export var mob_scene: PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

extends CanvasLayer
signal start_game

const LOBBY_PATH = "res://Scenes/main0.tscn"

func _ready():
	$BackLobby.hide()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	$ScoreLabel.text = "0"
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Avoid the Rats! Use AWSD to move"
	$Message.show()
	$BackLobby.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()


func _on_back_lobby_pressed() -> void:
	var new_scene_resource = load(LOBBY_PATH)
	get_tree().change_scene_to_packed(new_scene_resource)

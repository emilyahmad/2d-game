extends CanvasLayer

signal start_game
signal start_multiplayer_game
signal stop_music_pressed
signal pause_toggled

var winner_text;

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("You collected 10 fish!")
	await $MessageTimer.timeout
	await get_tree().create_timer(1).timeout
	$Message.text = "Collect Fish!"
	$Message.show()
	$StartButton.show()
	$MultiplayerButton.show()
	$ScoreLabel.text = "0"

func _display_winner(text):
	winner_text = text

func show_multiplayer_game_over():
	show_message(winner_text)
	await $MessageTimer.timeout
	await get_tree().create_timer(1).timeout
	$Message.text = "Collect Fish!"
	$Message.show()
	$StartButton.show()
	$MultiplayerButton.show()
	$ScoreLabel.text = "0"

func update_score(score):
	$ScoreLabel.text = str(score)

func update_player2_score(player2score):
	$Player2ScoreLabel.text = str(player2score)

func _on_start_button_pressed():
	$StartButton.hide()
	$MultiplayerButton.hide()
	$Player2ScoreLabel.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _on_multiplayer_button_pressed():
	$StartButton.hide()
	$MultiplayerButton.hide()
	$Player2ScoreLabel.show()
	start_multiplayer_game.emit()

func _on_mute_label_pressed():
	stop_music_pressed.emit()

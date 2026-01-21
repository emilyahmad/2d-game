extends CanvasLayer

signal start_game
signal stop_music_pressed
signal pause_toggled

var winner_text;

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("You caught 10 rats!")
	await $MessageTimer.timeout
	await get_tree().create_timer(1).timeout
	$Message.text = "Catch the Rats!"
	$Message.show()
	$StartButton.show()
	$ScoreLabel.text = "0"

func _display_winner(text):
	winner_text = text

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _on_mute_label_pressed():
	stop_music_pressed.emit()

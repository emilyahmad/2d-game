extends CanvasLayer

signal start_game

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
	$ScoreLabel.text = "0"

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()

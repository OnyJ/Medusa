extends Control

signal start_game
signal pause_game
signal continue_game
enum {
	GAMEOVER
	MENU
	PLAYING
	PAUSED
}
var state = MENU
var time_score = 0


func show_screen(name):
	match name:
		"GameOver":
			state = GAMEOVER
			$HUD/ScoreTimer.stop()
			$HUD/ScoreBackground.hide()
			$GameOver.show()
			yield(get_tree().create_timer(1.0), "timeout")
		"Menu":
			state = MENU
			$GameOver.hide()
			$HUD/ScoreBackground.hide()
			$Menu.show()
		"Game":
			state = PLAYING
			$HUD/ScoreTimer.start()
			$HUD/ScoreBackground.show()
			$GameOver.hide()
			$Menu.hide()
			$Pause.hide()
		"Pause":
			state = PAUSED
			emit_signal("pause_game")
			$Pause.show()
		"Continue":
			state = PLAYING
			emit_signal("continue_game")
			$Pause.hide()


func _on_Play_pressed():
	# set scores to 0
	# allow Medusa to move
	show_screen("Game")
	emit_signal("start_game")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if state == GAMEOVER:
			show_screen("Menu")
			get_tree().reload_current_scene()
		elif state == MENU:
			_on_Play_pressed()
		elif state == PLAYING:
			show_screen("Pause")
		elif state == PAUSED:
			show_screen("Continue")

func _on_ScoreTimer_timeout():
	time_score += 1
	$HUD/TimeScoreLabel.text = "Score: %s sec" % time_score

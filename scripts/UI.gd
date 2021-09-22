extends Control

signal start_game
var time_score = 0


func show_screen(name):
	match name:
		"GameOver":
			$HUD/ScoreTimer.stop()
			$HUD/ScoreBackground.hide()
			$GameOver.show()
			yield(get_tree().create_timer(1.0), "timeout")
		"Menu":
			$GameOver.hide()
			$HUD/ScoreBackground.hide()
			$Menu.show()
		"Game":
			$HUD/ScoreTimer.start()
			$HUD/ScoreBackground.show()
			$GameOver.hide()
			$Menu.hide()


func _on_Play_pressed():
	# set scores to 0
	# allow Medusa to move
	show_screen("Game")
	emit_signal("start_game")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		show_screen("Menu")
		get_tree().reload_current_scene()

func _on_ScoreTimer_timeout():
	time_score += 1
	$HUD/TimeScoreLabel.text = "Score: %s sec" % time_score

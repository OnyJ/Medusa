extends Node

export var game_is_started = false
export var game_over = false
export var game_paused = false


func _on_Map_petrified():
	game_over = true
	$UI.show_screen("GameOver")

func _on_UI_start_game():
	game_over = false
	game_paused = false
	game_is_started = true

func _on_UI_pause_game():
	game_paused = true
	game_over = false

func _on_UI_continue_game():
	game_paused = false
	game_over = false
	game_is_started = true

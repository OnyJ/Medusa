extends Node

export var game_is_started = false
export var game_over = false

func _on_UI_start_game():
	print("start game")
	game_over = false
	game_is_started = true


func _on_Map_petrified():
	game_over = true
	$UI.show_screen("GameOver")


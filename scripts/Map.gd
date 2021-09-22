extends Node

signal petrified
onready var main = $'../../Main'
onready var start = main.game_is_started

func _ready():
	if start == true:
		print(start)

func _on_Medusa_petrify():
	emit_signal("petrified")


func _on_UI_start_game():
#	get_tree().reload_current_scene()
	pass


func _on_FallArea_body_entered(body):
	# dead but no time to code
	emit_signal("petrified")

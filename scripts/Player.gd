extends KinematicBody

signal petrified

export var speed = 14
export var gravity = 75
var velocity = Vector3.ZERO
onready var main = $"../../../Main"


func _physics_process(delta):
	if (main.game_is_started 
		and !main.game_over 
		and !main.game_paused
		):
		handle_player_control(delta)


func handle_player_control(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1

	# turn character
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	# apply movement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity = move_and_slide(velocity, Vector3.UP)
	$AnimationPlayer.play("move")

	# gravity
	velocity.y -= gravity * delta


func get_petrified():
	emit_signal("petrified")
	main.game_over = true
	print(main.game_over)

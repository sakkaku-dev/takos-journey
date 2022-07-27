extends Node

export var acceleration := 800
export var speed := 200

onready var walk_sound := $WalkSound
onready var player = owner

func process(delta: float):
	var motion_x = player.input.get_action_strength("move_right") - player.input.get_action_strength("move_left")
	player.velocity.x = move_toward(player.velocity.x, motion_x * speed, acceleration * delta)
	
	if motion_x:
		player.sprite.scale.x = -1 if motion_x < 0 else 1

	if player.is_on_floor() and player.velocity:
		if not walk_sound.playing:
			walk_sound.play()
	else:
		walk_sound.stop()

func exit():
	walk_sound.stop()

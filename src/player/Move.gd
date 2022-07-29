extends Node

export var acceleration := 800
export var speed := 200

onready var gravity = ProjectSettings.get("physics/2d/default_gravity_vector") * ProjectSettings.get("physics/2d/default_gravity")

onready var walk_sound := $WalkSound
onready var player: Player = owner

func process(delta: float):
	if player.is_on_floor() and player.velocity:
		if not walk_sound.playing:
			walk_sound.play()
	else:
		walk_sound.stop()
	
	var motion_x = player.get_motion()
	player.velocity.x = move_toward(player.velocity.x, motion_x * speed, acceleration * delta)
	
	if motion_x:
		player.face_dir = Vector2.LEFT if motion_x < 0 else Vector2.RIGHT 
		
	if not player.is_on_floor() and player.is_moving_against_wall() and player.velocity.y > 0:
		player.state = Player.WALL_SLIDE
		
	player.velocity += gravity

func exit():
	walk_sound.stop()

func just_pressed(action: String):
	if player.is_on_floor() and action == "slide":
		player.state = Player.SLIDE
		
		
	if action == "jump":
		if player.is_on_floor():
			player.state = Player.JUMP
		elif player.get_wall_collision():
			player.state = Player.WALL_JUMP

func just_released(action: String):
	if action == "jump":
		if player.velocity.y < 0:
			player.velocity.y = 0

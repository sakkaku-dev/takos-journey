extends State

export var acceleration := 800
export var speed := 200

export var run_particles_path: NodePath
onready var run_particle := get_node(run_particles_path)

onready var gravity = ProjectSettings.get("physics/2d/default_gravity_vector") * ProjectSettings.get("physics/2d/default_gravity")

onready var walk_sound := $WalkSound
onready var player: Player = owner

func process(delta: float):
	if player.is_on_floor() and player.velocity:
		if not walk_sound.playing:
			walk_sound.play()
		run_particle.emitting = true
	else:
		walk_sound.stop()
		run_particle.emitting = false
		
	var motion_x = player.get_motion()
	player.velocity.x = move_toward(player.velocity.x, motion_x * speed, acceleration * delta)
	
	if motion_x:
		player.face_dir = Vector2.LEFT if motion_x < 0 else Vector2.RIGHT 
		
	if not player.is_on_floor() and player.is_moving_against_wall() and player.velocity.y >= 0:
		player.state = Player.WALL_SLIDE
		
	player.velocity += gravity

func exit():
	walk_sound.stop()
	run_particle.emitting = false

func just_pressed(action: String):
	if action == "slide":
		if not player.tentacle_mode:
			player.state = Player.SLIDE
		else:
			player.state = Player.DASH
		
		
	elif action == "jump":
		if player.is_on_floor():
			player.state = Player.JUMP
		elif player.get_wall_collision():
			player.state = Player.WALL_JUMP
			
	elif action == "switch_mode" and player.holding_book:
		player.tentacle_mode = !player.tentacle_mode

func just_released(action: String):
	if action == "jump":
		if player.velocity.y < 0:
			player.velocity.y = 0

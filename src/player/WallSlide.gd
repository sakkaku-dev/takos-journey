extends State

export var jump_force := 400
export var jump_angle := 65.0
export var slide_terminal_velocity := 10
export var leave_slide_threshold := 0.2

onready var gravity = ProjectSettings.get("physics/2d/default_gravity_vector") * ProjectSettings.get("physics/2d/default_gravity")
onready var slide_sound := $SlideSound
onready var land_sound := $LandSound

onready var player: Player = owner

var leave_motion := 0.0

func enter():
	leave_motion = 0
	player.face_dir = player.get_wall_collision() * -1
	land_sound.play()
	slide_sound.play()

func exit():
	slide_sound.stop()

func process(delta):
	player.velocity += gravity
	if player.velocity.y >= slide_terminal_velocity:
		player.velocity.y = slide_terminal_velocity
	
	if player.get_motion() == player.face_dir.x:
		leave_motion += delta
	else:
		leave_motion = 0
		
	var moved_away_from_wall = leave_motion >= leave_slide_threshold
	if player.is_on_floor() or not player.get_wall_collision() or moved_away_from_wall:
		player.state = Player.MOVE


func just_pressed(action: String):
	if action == "jump":
		player.state = Player.WALL_JUMP

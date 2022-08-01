extends State

export var deacceleration := 1500
export var dash_speed := 500
export var dash_threshold := 0.0
export var max_dash := 1

onready var player: Player = owner

var motion := Vector2.ZERO
var to_wall_slide = false

func can_enter():
	return player.dash_count < max_dash and player.tentacle_mode

func enter():
	motion = player.face_dir * dash_speed
	player.dash_count += 1
	player.velocity.y = 0
	to_wall_slide = false

func process(delta: float):
	motion = motion.move_toward(Vector2.ZERO, deacceleration * delta)
	player.velocity.x = motion.x
	
	if player.get_wall_collision() and not player.is_on_floor():
		to_wall_slide = true
	
	if abs(motion.x) <= dash_threshold:
		player.state = Player.WALL_SLIDE if to_wall_slide else Player.MOVE
	

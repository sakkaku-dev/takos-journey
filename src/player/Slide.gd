extends State

export var slide_speed := 300
export var slide_deacceleration := 800
export var slide_threshold := 0.1

export var particles_path: NodePath
onready var particles := get_node(particles_path)

onready var slide_sound := $SlideSound

onready var player: Player = owner

var motion := Vector2.ZERO

func enter():
	motion = player.face_dir * slide_speed
	slide_sound.play()
	particles.emitting = true

func process(delta: float):
	if abs(motion.x) <= slide_threshold or not player.is_on_floor():
		player.state = Player.MOVE
	
	motion = motion.move_toward(Vector2.ZERO, slide_deacceleration * delta)
	player.velocity.x = motion.x
	player.velocity.y = Vector2.DOWN.y * 10 # move down so is_on_floor() stays true

func exit():
	particles.emitting = false

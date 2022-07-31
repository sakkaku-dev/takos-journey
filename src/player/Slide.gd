extends State

export var slide_speed := 300
export var slide_deacceleration := 800
export var slide_threshold := 0.1

export var particles_path: NodePath
onready var particles := get_node(particles_path)

onready var slide_sound := $SlideSound

onready var player: Player = owner

func enter():
	player.velocity = player.face_dir * slide_speed
	slide_sound.play()

func process(delta: float):
	if abs(player.velocity.x) <= slide_threshold:
		player.state = Player.MOVE
	
	particles.start()
	player.velocity.x = move_toward(player.velocity.x, 0, slide_deacceleration * delta)

func exit():
	slide_sound.stop()

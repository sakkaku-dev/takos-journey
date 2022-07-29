extends State

export var slide_speed := 300
export var slide_deacceleration := 800
export var slide_threshold := 0.1

onready var slide_sound := $SlideSound
onready var player: Player = owner

func enter():
	player.velocity = player.face_dir * slide_speed
	slide_sound.play()

func process(delta: float):
	if abs(player.velocity.x) <= slide_threshold:
		player.state = Player.MOVE
	
	player.velocity.x = move_toward(player.velocity.x, 0, slide_deacceleration * delta)

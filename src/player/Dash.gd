extends State

export var deacceleration := 1500
export var dash_speed := 500
export var dash_threshold := 0.5
export var max_dash := 1

onready var player: Player = owner

func enter():
	if player.dash_count >= max_dash:
		player.state = Player.MOVE
		return
	
	player.velocity = player.face_dir * dash_speed
	player.dash_count += 1

func process(delta: float):
	if abs(player.velocity.x) <= dash_threshold:
		player.state = Player.MOVE
	
	player.velocity.x = move_toward(player.velocity.x, 0, deacceleration * delta)

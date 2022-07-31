extends State

export var jump_force := 500
export var jump_angle := 50.0

export var particles_path: NodePath
onready var particles := get_node(particles_path)

onready var jump_sound := $JumpSound

onready var player: Player = owner

func enter():
	var dir = player.get_wall_collision() * -1
	if dir:
		dir = dir.rotated(deg2rad(jump_angle) * -sign(dir.x))
		
		player.velocity += dir * jump_force
		player.face_dir = Vector2(sign(dir.x), 0)
		jump_sound.play()
		particles.start()
	
	player.state = Player.MOVE

extends State

export var jump_force := 300

export var particles_path: NodePath
onready var particles := get_node(particles_path)

onready var jump_sound := $JumpSound
onready var player: Player = owner

func enter(dir = Vector2.UP):
	player.velocity += dir * jump_force
	jump_sound.play()
	
	particles.start()
	player.state = Player.MOVE

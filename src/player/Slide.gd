extends Node

export var slide_force := 5
export var slide_deacceleration := 800
export var slide_threshold := 10

onready var slide_sound := $SlideSound
onready var player: Player = owner

func enter():
	if player.state == Player.SLIDE:
		return
	
	player.state = Player.SLIDE
	player.velocity.x *= slide_force
	slide_sound.play()

func process(delta: float):
	if abs(player.velocity.x) <= slide_threshold:
		player.state = Player.MOVE
	
	player.velocity.x = move_toward(player.velocity.x, 0, slide_deacceleration * delta)

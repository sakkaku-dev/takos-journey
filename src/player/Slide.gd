extends Node

export var slide_force := 5
export var slide_deacceleration := 800

onready var player: Player = owner

func enter():
	if player.state == Player.SLIDE:
		return
	
	player.state = Player.SLIDE
	player.velocity.x *= slide_force

func process(delta: float):
	if abs(player.velocity.x) <= 0:
		player.state = Player.MOVE
	
	player.velocity.x = move_toward(player.velocity.x, 0, slide_deacceleration * delta)

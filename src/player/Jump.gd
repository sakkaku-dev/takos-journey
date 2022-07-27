extends Node

export var jump_force := 300

onready var jump_sound := $JumpSound
onready var player: Player = owner

func enter():
	player.velocity.y = -jump_force
	jump_sound.play()

func exit():
	if player.velocity.y < 0:
		player.velocity.y = 0

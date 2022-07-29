extends Node

export var jump_force := 300

onready var jump_sound := $JumpSound
onready var player: Player = owner

func enter(dir = Vector2.UP):
	player.velocity += dir * jump_force
	jump_sound.play()
	
	player.state = Player.MOVE

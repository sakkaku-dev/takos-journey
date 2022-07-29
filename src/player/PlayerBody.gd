extends Node2D

onready var player: Player = owner

func _process(delta):
	scale.x = sign(player.face_dir.x)

extends Node2D

onready var tentacles := $Tentacles

onready var player: Player = owner

func _process(delta):
	scale.x = sign(player.face_dir.x)
	tentacles.visible = player.tentacle_mode

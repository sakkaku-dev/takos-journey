extends Node2D

onready var tentacles := $Tentacles
onready var book := $Book

onready var player: Player = owner

func _process(delta):
	scale.x = sign(player.face_dir.x)
	tentacles.visible = player.tentacle_mode

func _on_Tentacles_visibility_changed():
	book.animation = "open" if tentacles.visible else "close"

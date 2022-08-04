extends Node

signal exceeded_limit()

export var limit := 5

onready var player: Player = owner

var time := 0.0

func _process(delta):
	if player.tentacle_mode:
		time += delta
	else:
		time = 0
	
	if time >= limit:
		time = 0
		emit_signal("exceeded_limit")

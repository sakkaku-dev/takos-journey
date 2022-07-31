extends Node

export var particles_path: NodePath
onready var particles = get_node(particles_path)

onready var land_sound := $LandSound
onready var player: Player = owner

func enter():
	land_sound.play()
	particles.emitting = true

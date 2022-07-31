extends Node

export var land_particles: PackedScene

onready var land_sound := $LandSound
onready var player: Player = owner

func enter():
	land_sound.play()
	
	var particles = land_particles.instance()
	get_tree().current_scene.add_child(particles)
	particles.global_position = player.global_position + Vector2.DOWN * 12
	particles.scale.x = sign(player.face_dir.x)
	particles.emitting = true

extends Node2D

export var particles: PackedScene

onready var timer := $Timer

var _spawned = false

func start():
	if _spawned: return
	
	_spawn_particle()
	_spawned = true
	timer.start()

func _spawn_particle():
	var node = particles.instance()
	node.global_position = global_position
	get_tree().current_scene.add_child(node)
	node.rotation_degrees = rotation_degrees * sign(get_parent().scale.x)


func _on_Timer_timeout():
	_spawned = false

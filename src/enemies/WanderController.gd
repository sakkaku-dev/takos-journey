extends Node2D

signal update_position(pos)

export var wander_range := 25.0
export var min_wander_timer := 1.0
export var max_wander_timer := 5.0

onready var timer := $Timer
onready var start_position := global_position

var logger = Logger.new("WanderController")

func start_wander():
	if timer.time_left != 0:
		return
	
	timer.start(rand_range(min_wander_timer, max_wander_timer))
	logger.debug("Starting wander timer %s" % timer.time_left)


func _on_Timer_timeout():
	_update_wander_position()


func _update_wander_position():
	var pos = Vector2(
		rand_range(-wander_range, wander_range),
		rand_range(-wander_range, wander_range)
	)
	
	var target_pos = start_position + pos
	logger.debug("New wander position %s" % target_pos)
	emit_signal("update_position", target_pos)


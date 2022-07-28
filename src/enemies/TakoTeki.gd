class_name Enemy extends KinematicBody2D

export var acceleration := 1000
export var speed := 50

export var wander_range := 25.0

onready var gravity: Vector2 = ProjectSettings.get("physics/2d/default_gravity_vector") * ProjectSettings.get("physics/2d/default_gravity")
onready var sprite := $Sprite
onready var wander_timer := $WanderTimer

onready var start_pos := global_position
onready var target_pos := start_pos

var logger = Logger.new("Enemy")

var velocity := Vector2.ZERO
var player: Node2D
var is_wandering = false

func _physics_process(delta):
	if player:
		target_pos = player.global_position
	else:
		if not is_wandering and wander_timer.time_left == 0:
			logger.debug("Start wander timer")
			wander_timer.start()
	
	_move(delta)
	
	velocity += gravity
	velocity = move_and_slide(velocity, Vector2.UP)


func _move(delta):
	var dir = target_pos.x - global_position.x
	var motion_x = sign(dir) if abs(dir) >= 1 else 0
	
	if velocity and motion_x == 0:
		is_wandering = false
	
	velocity.x = move_toward(velocity.x, motion_x * speed, acceleration * delta)
	if motion_x:
		sprite.scale.x = -1 if motion_x < 0 else 1


func _on_PlayerDetector_body_entered(body):
	player = body


func _on_PlayerDetector_body_exited(body):
	player = null


func _on_WanderTimer_timeout():
	is_wandering = true
	
	var pos = Vector2(
		rand_range(-wander_range, wander_range),
		rand_range(-wander_range, wander_range)
	)
	
	target_pos = start_pos + pos
	logger.debug("New target position %s" % target_pos)

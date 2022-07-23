extends KinematicBody2D

export var acceleration := 800
export var speed := 200

export var jump_force := 800
export var gravity_force := 2000

onready var input := $PlayerInput
onready var sprite := $Sprite
onready var anim := $AnimationPlayer

var gravity := Vector2.DOWN
var velocity := Vector2.ZERO

func _physics_process(delta):
	var desired_velocity = _get_motion() * speed
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	
	if not is_on_floor():
		velocity += gravity * gravity_force * delta
	
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP, true, 4, deg2rad(70))

	if desired_velocity:
		sprite.scale.x = -1 if desired_velocity.x < 0 else 1
	
	if velocity:
		if is_on_floor():
			anim.play("Run")
		else:
			if velocity.y > 0.01:
				anim.play("Fall")
			elif velocity.y < -0.01:
				anim.play("Jump")
	else:
		anim.play("Idle")


func _get_motion():
	return Vector2(input.get_action_strength("move_right") - input.get_action_strength("move_left"), 0)


func _on_PlayerInput_just_pressed(action):
	if action == "jump" and is_on_floor():
		velocity += Vector2.UP * jump_force

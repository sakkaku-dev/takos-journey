extends KinematicBody2D

export var acceleration := 800
export var speed := 200

export var jump_force := 300
export var initial_gravity_force := 9.8

onready var input := $PlayerInput
onready var sprite := $Sprite
onready var anim := $AnimationPlayer

onready var walk_sound := $WalkSound
onready var land_sound := $LandSound
onready var jump_sound := $JumpSound

var velocity := Vector2.ZERO

func _physics_process(delta):
	var was_grounded = is_on_floor()
	
	var motion_x = input.get_action_strength("move_right") - input.get_action_strength("move_left")
	velocity.x = move_toward(velocity.x, motion_x * speed, acceleration * delta)
	velocity += Vector2.DOWN * initial_gravity_force
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if motion_x:
		sprite.scale.x = -1 if motion_x < 0 else 1
	
	if not was_grounded and is_on_floor():
		land_sound.play()
	
	if velocity:
		if is_on_floor():
			anim.play("Run")
			if not walk_sound.playing:
				walk_sound.play()
		else:
			walk_sound.stop()
			if velocity.y > 0.01:
				anim.play("Fall")
			elif velocity.y < -0.01:
				anim.play("Jump")
	else:
		anim.play("Idle")
		walk_sound.stop()


func _on_PlayerInput_just_pressed(action):
	if action == "jump" and is_on_floor():
		velocity.y = -jump_force
		jump_sound.play()


func _on_PlayerInput_just_released(action):
	if action == "jump":
		if velocity.y < 0:
			velocity.y = 0

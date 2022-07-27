class_name Player extends KinematicBody2D

enum {
	MOVE,
	SLIDE,
}

export var acceleration := 800
export var speed := 200

export var slide_force := 5
export var slide_deacceleration := 800

export var jump_force := 300
export var initial_gravity_force := 9.8

onready var input := $PlayerInput
onready var sprite := $Sprite
onready var anim_tree := $AnimationTree

onready var walk_sound := $WalkSound
onready var land_sound := $LandSound
onready var jump_sound := $JumpSound

var velocity := Vector2.ZERO
var state = MOVE

func _process(_delta):
	anim_tree.update_animation(self)


func _physics_process(delta):
	var was_grounded = is_on_floor()
	
	match state:
		MOVE: _move(delta)
		SLIDE: _slide(delta)
	
	velocity += Vector2.DOWN * initial_gravity_force
	velocity = move_and_slide(velocity, Vector2.UP)
	
	_update_sound(was_grounded)


func _move(delta: float):
	var motion_x = input.get_action_strength("move_right") - input.get_action_strength("move_left")
	velocity.x = move_toward(velocity.x, motion_x * speed, acceleration * delta)
	
	if motion_x:
		sprite.scale.x = -1 if motion_x < 0 else 1


func _slide(delta: float):
	if abs(velocity.x) <= 0:
		state = MOVE
	
	velocity.x = move_toward(velocity.x, 0, slide_deacceleration * delta)


func _update_sound(was_grounded: bool):
	# TODO: make better
	if is_on_floor():
		if velocity:
			if not walk_sound.playing:
				walk_sound.play()
		else:
			walk_sound.stop()
		if not was_grounded:
			land_sound.play()
	else:
		walk_sound.stop()


func _on_PlayerInput_just_pressed(action):
	if action == "jump":
		velocity.y = -jump_force
		jump_sound.play()
	elif action == "slide" and state != SLIDE:
		state = SLIDE
		velocity.x *= slide_force


func _on_PlayerInput_just_released(action):
	if action == "jump":
		if velocity.y < 0:
			velocity.y = 0

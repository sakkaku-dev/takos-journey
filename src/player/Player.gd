class_name Player extends KinematicBody2D

enum {
	MOVE,
	SLIDE,
}

onready var input := $PlayerInput
onready var sprite := $Sprites
onready var anim_tree := $AnimationTree

onready var land_sound := $LandSound

onready var jump := $States/Jump
onready var slide := $States/Slide
onready var move := $States/Move

var velocity := Vector2.ZERO
var state = MOVE setget _set_state

onready var gravity = ProjectSettings.get("physics/2d/default_gravity_vector") * ProjectSettings.get("physics/2d/default_gravity")

func _set_state(s):
	state = s

func _process(_delta):
	anim_tree.update_animation(self)


func _physics_process(delta):
	var was_grounded = is_on_floor()
	
	match state:
		MOVE: move.process(delta)
		SLIDE: slide.process(delta)
	
	velocity += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	_update_sound(was_grounded)


func _update_sound(was_grounded: bool):
	if is_on_floor() and not was_grounded:
		land_sound.play()


func _on_PlayerInput_just_pressed(action):
	if is_on_floor():
		if action == "jump":
			move.exit()
			jump.enter()
		elif action == "slide":
			move.exit()
			slide.enter()


func _on_PlayerInput_just_released(action):
	if action == "jump":
		jump.exit()

class_name Player extends KinematicBody2D

enum {
	MOVE,
	SLIDE,
	WALL_SLIDE,
	WALL_JUMP,
	JUMP,
	DASH,
}

onready var input := $DeviceSwitcher/PlayerInput
onready var sprite := $Sprites
onready var anim_tree := $AnimationTree

onready var jump := $States/Jump
onready var slide := $States/Slide
onready var move := $States/Move
onready var wall_slide := $States/WallSlide
onready var wall_jump := $States/WallJump
onready var dash := $States/Dash
onready var land := $States/Land

onready var left_wall_cast := $WallCast/LeftWall
onready var right_wall_cast := $WallCast/RightWall

var logger = Logger.new("Player")

var face_dir := Vector2.RIGHT
var velocity := Vector2.ZERO
var state := MOVE setget _set_state
var tentacle_mode := false
var dash_count = 0

func _set_state(s):
	if state == s or not _get_state_node(s).can_enter():
		return
	
	_current_state().exit()
	state = s
	_current_state().enter()
	logger.debug("Changed to state %s" % _current_state())

func _get_state_node(s):
	match s:
		SLIDE: return slide
		MOVE: return move
		WALL_SLIDE: return wall_slide
		WALL_JUMP: return wall_jump
		JUMP: return jump
		DASH: return dash

func _current_state() -> State:
	return _get_state_node(state)

func _process(_delta):
	anim_tree.update_animation(self)

func _physics_process(delta):
	var was_grounded = is_on_floor()
	
	_current_state().process(delta)
	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor() or state == WALL_SLIDE:
		reset_dash()
		
	if is_on_floor() and not was_grounded:
		land.enter()


func _on_PlayerInput_just_pressed(action):
	_current_state().just_pressed(action)

func _on_PlayerInput_just_released(action):
	_current_state().just_released(action)


func get_motion():
	return input.get_action_strength("move_right") - input.get_action_strength("move_left")

func get_wall_collision():
	if left_wall_cast.is_colliding():
		return Vector2.LEFT
	if right_wall_cast.is_colliding():
		return Vector2.RIGHT
	return Vector2.ZERO

func is_moving_against_wall():
	return is_on_wall() and get_wall_collision()

func reset_dash():
	dash_count = 0

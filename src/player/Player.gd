class_name Player extends KinematicBody2D

enum {
	MOVE,
	SLIDE,
	WALL_SLIDE,
	WALL_JUMP,
	JUMP,
}

onready var input := $PlayerInput
onready var sprite := $Sprites
onready var anim_tree := $AnimationTree

onready var land_sound := $LandSound

onready var jump := $States/Jump
onready var slide := $States/Slide
onready var move := $States/Move
onready var wall_slide := $States/WallSlide
onready var wall_jump := $States/WallJump

onready var left_wall_cast := $WallCast/LeftWall
onready var right_wall_cast := $WallCast/RightWall

var logger = Logger.new("Player")

var face_dir := Vector2.RIGHT
var velocity := Vector2.ZERO
var state := MOVE setget _set_state

func _set_state(s):
	if state == s:
		return
	
	logger.debug("Changing to state %s" % _get_state_node(s))
	_run_method_if_exist(_get_state_node(state), "exit")
	state = s
	_run_method_if_exist(_get_state_node(state), "enter")

func _get_state_node(s):
	match s:
		SLIDE: return slide
		MOVE: return move
		WALL_SLIDE: return wall_slide
		WALL_JUMP: return wall_jump
		JUMP: return jump

func _run_method_if_exist(node: Node, method, params = []):
	if node.has_method(method):
		node.callv(method, params)


func _process(_delta):
	anim_tree.update_animation(self)

func _physics_process(delta):
	var was_grounded = is_on_floor()
	
	_run_method_if_exist(_get_state_node(state), "process", [delta])
	velocity = move_and_slide(velocity, Vector2.UP)

	if not was_grounded and is_on_floor():
		land_sound.play()


func _on_PlayerInput_just_pressed(action):
	_run_method_if_exist(_get_state_node(state), "just_pressed", [action])

func _on_PlayerInput_just_released(action):
	_run_method_if_exist(_get_state_node(state), "just_released", [action])


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

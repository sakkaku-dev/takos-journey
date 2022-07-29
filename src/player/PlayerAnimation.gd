extends AnimationTree

onready var anim := $AnimationPlayer

const GROUNDED = "parameters/conditions/grounded"

const FALLING = "parameters/conditions/falling"
const RISING = "parameters/conditions/rising"

const MOVING = "parameters/grounded/conditions/moving"
const NOT_MOVING = "parameters/grounded/conditions/not_moving"
const SLIDING = "parameters/grounded/conditions/sliding"
const NOT_SLIDING = "parameters/grounded/conditions/not_sliding"

const WALL_SLIDING = "parameters/conditions/sliding"
const NOT_WALL_SLIDING = "parameters/conditions/not_sliding"

func _ready():
	active = true

func update_animation(player: Player):
	set(GROUNDED, player.is_on_floor())
	
	set(FALLING, not get(GROUNDED) and player.velocity.y >= 0)
	set(RISING, not get(GROUNDED) and not get(FALLING))
	
	set(MOVING, abs(player.velocity.x) > 0)
	set(NOT_MOVING, not get(MOVING))

	set(SLIDING, player.state == Player.SLIDE)
	set(NOT_SLIDING, not get(SLIDING))
	
	set(WALL_SLIDING, player.state == Player.WALL_SLIDE)
	set(NOT_WALL_SLIDING, not get(WALL_SLIDING))

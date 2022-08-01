extends AnimationTree

onready var anim := $AnimationPlayer
onready var tentacle_anim := $TentaclesAnimation

const GROUNDED = "parameters/Main/conditions/grounded"

const FALLING = "parameters/Main/conditions/falling"
const RISING = "parameters/Main/conditions/rising"

const MOVING = "parameters/Main/Grounded/conditions/moving"
const NOT_MOVING = "parameters/Main/Grounded/conditions/not_moving"
const SLIDING = "parameters/Main/Grounded/conditions/sliding"
const NOT_SLIDING = "parameters/Main/Grounded/conditions/not_sliding"

const WALL_SLIDING = "parameters/Main/conditions/sliding"
const NOT_WALL_SLIDING = "parameters/Main/conditions/not_sliding"

const DASH = "parameters/Main/conditions/dash"
const NOT_DASH = "parameters/Main/conditions/not_dash"

const TENTACLE_ON = "parameters/TentaclesOn/active"
const TENTACLE_OFF = "parameters/TentaclesOff/active"

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
	
	set(DASH, player.state == Player.DASH)
	set(NOT_DASH, not get(DASH))
	
#	set(TENTACLE_ON, player.tentacle_mode)
#	set(TENTACLE_OFF, not player.tentacle_mode)
	

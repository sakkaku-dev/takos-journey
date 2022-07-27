extends AnimationTree

onready var anim := $AnimationPlayer

const GROUNDED = "parameters/conditions/grounded"
const NOT_GROUNDED = "parameters/conditions/not_grounded"

const FALLING = "parameters/conditions/falling"
const RISING = "parameters/conditions/rising"

const MOVING = "parameters/grounded/conditions/moving"
const NOT_MOVING = "parameters/grounded/conditions/not_moving"
const SLIDING = "parameters/grounded/conditions/sliding"
const NOT_SLIDING = "parameters/grounded/conditions/sliding"


func update_animation(player: Player):
	set(GROUNDED, player.is_on_floor())
	set(NOT_GROUNDED, not get(GROUNDED))
	
	set(FALLING, player.velocity.y >= 0)
	set(RISING, not get(FALLING))
	
	set(MOVING, abs(player.velocity.x) > 0)
	set(NOT_MOVING, not get(MOVING))


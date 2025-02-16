class_name Backflip
extends PlayerState
## Jumping backwards from a crouch.

@export var jump_power: float = 9.1
## How much the backflip sends you backwards.
@export var push_power: float = 1.4

## If the activate_freefall_timer() function should be called.
var start_freefall_timer: bool = false


func _on_enter(_param):
	start_freefall_timer = false
	actor.vel.y = -jump_power
	actor.vel.x = push_power * -movement.facing_direction


func _physics_tick():
	if InputManager.is_moving_x():
		movement.move_x_analog(0.06, false)

	if actor.vel.y > 0 and not start_freefall_timer:
		start_freefall_timer = true

		movement.activate_freefall_timer()


func _subsequent_ticks():
	movement.apply_gravity()


func _trans_rules():
	if actor.push_rays.is_colliding(false, true) and input.buffered_input(&"jump"):
		return [&"Walljump", -actor.push_rays.get_collide_side()]

	if movement.can_init_wallslide(true):
		movement.facing_direction = actor.push_rays.get_collide_side()
		movement.update_direction(movement.facing_direction)

		return &"Wallslide"

	if not movement.dived and movement.can_air_action() and input.buffered_input(&"dive"):
		return &"Dive"

	if movement.can_spin() and input.buffered_input(&"spin"):
		return &"Spin"

	if Input.is_action_just_pressed(&"groundpound") and movement.can_air_action():
		return &"GroundPound"

	if actor.is_on_floor():
		return &"Cheer"

	if movement.finished_freefall_timer():
		return &"Freefall"

	return &""

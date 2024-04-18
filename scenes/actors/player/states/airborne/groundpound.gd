class_name GroundPound
extends PlayerState
## Pressing down while airborne.


## How much the groundpound offsets you on the Y axis.
@export var gp_offset: float = -5

@export var linger_time: float = 20
var linger_timer: float


func _on_enter(_handover):
	movement.consume_coyote_timer()
	movement.body_rotation = 0

	actor.vel.y = 0
	actor.vel.x = 0

	actor.doll.rotation = 0
	actor.position.y += gp_offset

	linger_timer = linger_time


func _physics_tick():
	if not actor.doll.is_playing():
		linger_timer = max(linger_timer - 1, 0)


func _trans_rules():
	if movement.can_air_action() and input.buffered_input(&"dive"):
		return &"OdysseyDive"

	if linger_timer == 0:
		return &"GroundPoundFall"

	return &""

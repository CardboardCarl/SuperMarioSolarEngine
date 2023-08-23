class_name FallState
extends State
# Falling state


@onready var idle_state : State = %Idle


func physics_tick(_delta):
	actor.movement.move_x("air", true)
	actor.movement.apply_gravity()


func switch_check():
	if actor.is_on_floor():
		return idle_state

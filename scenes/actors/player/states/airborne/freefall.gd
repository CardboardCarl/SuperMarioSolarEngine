class_name Freefall
extends Fall
## Uninterupted falling at terminal velocity.


func _on_enter(_handover):
	movement.consume_freefall_timer()


func _tell_switch():
	if movement.can_spin() and input.buffered_input(&"spin"):
		return &"Spin"

	if Input.is_action_just_pressed(&"dive") and movement.can_air_action():
		return &"AirborneDive"

	if Input.is_action_just_pressed(&"down") and movement.can_air_action():
		return &"GroundPound"

	if movement.can_wallslide():
		return &"Wallslide"

	return &""

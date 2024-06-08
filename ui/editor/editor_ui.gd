class_name LevelEditorUI
extends CanvasLayer


@export_category(&"UI Buttons")
@export var z_toggle: CheckButton
@export var z_layer: SpinBox

@export_category(&"Popup Windows")
@export var quit_confirm: ConfirmationDialog


func _process(_delta):
	_z_view_behaviour()


func _unhandled_input(event):
	if event.is_action_pressed(&"e_toggle_ui"):
		visible = !visible


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit_confirm.visible = true


func _z_view_behaviour():
	z_layer.editable = z_toggle.button_pressed


func _on_quit_confirm_confirmed():
	get_tree().quit()

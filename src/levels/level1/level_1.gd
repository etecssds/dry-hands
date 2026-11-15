class_name Level1
extends BaseLevel


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not is_instance_valid(_DialogScreen):
		open_dialog()

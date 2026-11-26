class_name Level1
extends BaseLevel


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("interact") and not is_instance_valid(_DialogScreen):
		#open_dialog()

func _on_intro_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/intro.json")

func _on_sofrimento_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/sofrimentoAposSeca.json")

func _on_esperança_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/Esperança.json")

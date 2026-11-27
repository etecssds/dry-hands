class_name Level1
extends BaseLevel




func _on_intro_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/intro.json")
		$introArea.queue_free()
		

func _on_sofrimento_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/sofrimentoAposSeca.json")
		$sofrimentoArea.queue_free()


func _on_esperança_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		open_dialog("res://ui/dialog/dialogs/Esperança.json")
		$"esperançaArea2".queue_free()


func _on_level_2_transition_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		GlobalInventory.change_scene = true
		get_tree().change_scene_to_file("res://levels/level2/level2.tscn")

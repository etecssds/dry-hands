extends Node2D

func testEsc() -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _process(delta: float) -> void:
	testEsc()

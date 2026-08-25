extends Control

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$Transition.play("fade_out")
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func skipIntro():
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _process(_delta: float) -> void:
	skipIntro()

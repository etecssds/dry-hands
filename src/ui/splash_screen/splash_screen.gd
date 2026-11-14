class_name SplashScreen
extends Control


func _input(_event: InputEvent) -> void:
	if _event.is_action_pressed("skip_intro"):
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

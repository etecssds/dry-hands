class_name PauseMenu
extends Control

@onready var PauseMenu: Control = $"."


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if not PauseMenu.visible:
			pause()
		elif PauseMenu.visible:
			resume_anim()


func pause() -> void:
	get_tree().paused = true
	PauseMenu.visible = true
	$PauseTransition.play("fade_in")


func resume_anim() -> void:
	$PauseTransition.play("fade_out")


func resume() -> void:
	get_tree().paused = false
	PauseMenu.visible = false


func _on_pause_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		resume()


func _on_resume_button_pressed() -> void:
	resume_anim()


func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

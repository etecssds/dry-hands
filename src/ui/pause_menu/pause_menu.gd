extends Control
@onready var pause_menu: Control = $"."

func pause() -> void:
    get_tree().paused = true
    pause_menu.visible = true
    $PauseTransition.play("fade_in")


func resume_anim() -> void:
    $PauseTransition.play("fade_out")

func resume() -> void:
    get_tree().paused = false
    pause_menu.visible = false
    
func _on_pause_transition_animation_finished(anim_name: StringName) -> void:
    if anim_name == "fade_out":
        resume()

func paused() -> void:
    if Input.is_action_just_pressed("pause") and get_tree().paused == false:
        pause()
    elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
        resume_anim()


func _on_resume_button_pressed() -> void:
    resume_anim()

func _on_restart_button_pressed() -> void:
    resume()
    get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
    resume()
    get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _process(_delta: float) -> void:
    paused()

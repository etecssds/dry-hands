extends Control
@onready var pause_menu: Control = $"."

func _ready() -> void:
	pause_menu.visible = false
	
func resume():
	get_tree().paused = false
	pause_menu.visible = get_tree().paused
	
func pause():
	get_tree().paused = true
	pause_menu.visible = get_tree().paused
	
func paused():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
		$PauseTransition.play("fade_in")
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		$PauseTransition.play("fade_out")
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_retry_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_save_exit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func _process(_delta: float) -> void:
	paused()

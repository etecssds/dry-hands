class_name PauseMenu
extends Control

@onready var _PauseMenu: Control = $"."
@onready var audioPlayer: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	$MenuContainer/VBoxContainer/ResumeButton.grab_focus()
	pause()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if _PauseMenu.visible:
			resume_anim()

func pause() -> void:
	get_tree().paused = true
	_PauseMenu.visible = true
	$PauseTransition.play("fade_in")

func resume_anim() -> void:
	$PauseTransition.play("fade_out")

func resume() -> void:
	get_tree().paused = false
	_PauseMenu.visible = false
	queue_free()

func restart():
	resume()
	GlobalInventory.restart_inventory()
	get_tree().reload_current_scene()

func _on_pause_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		resume()

func _on_resume_button_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	resume_anim()

func _on_restart_button_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	restart()

func _on_exit_button_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	resume()
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func sonudSelector():
	var sound: int = randi_range(1,3)
	if sound == 1:
		audioPlayer.stream = load("res://assets/sounds/click1.wav")
	elif sound == 2: 
		audioPlayer.stream = load("res://assets/sounds/click2.mp3")
	elif sound == 3:
		audioPlayer.stream = load("res://assets/sounds/click3.ogg")
	audioPlayer.play()

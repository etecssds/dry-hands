class_name MainMenu
extends Control

@export_category("Objects")
@export var _version: StringName = "res://ui/main_menu/version.txt"

@onready var VersionLabel: Label = $Footer/Version
@onready var audioPlayer: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	VersionLabel.text = "Versão " + FileAccess.get_file_as_string(_version).strip_edges()
	$LogoMenuVBox/ButtonsContainer/Buttons/Play.grab_focus()


func _on_play_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	get_tree().change_scene_to_file("res://levels/level1/level1.tscn")
	

func _on_exit_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	get_tree().quit()
	

func _on_credits_button_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	$Credits/CreditsTransition.play("fade_in")
	$Credits/VBoxContainer/CreditsTitle/QuitCreditsButton.grab_focus()
	

func _on_quit_credits_button_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	$Credits/CreditsTransition.play("fade_out")
	$LogoMenuVBox/ButtonsContainer/Buttons/Play.grab_focus()
	

func _on_settings_button_pressed() -> void:
	pass # TODO: Settings UI

func sonudSelector():
	var sound: int = randi_range(1,3)
	if sound == 1:
		audioPlayer.stream = load("res://assets/sounds/click1.wav")
	elif sound == 2: 
		audioPlayer.stream = load("res://assets/sounds/click2.mp3")
	elif sound == 3:
		audioPlayer.stream = load("res://assets/sounds/click3.ogg")
	audioPlayer.play()

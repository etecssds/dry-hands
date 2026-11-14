class_name MainMenu
extends Control

@export_category("Objects")
@export var _version: String = "res://ui/main_menu/version.txt"

@onready var VersionLabel: Label = $MarginContainer/FooterContainer/Version


func _ready() -> void:
	VersionLabel.text = "Versão " + FileAccess.get_file_as_string(_version)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level1/level1.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	$CreditsContainer/CreditsTransition.play("fade_in")


func _on_quit_credits_button_pressed() -> void:
	$CreditsContainer/CreditsTransition.play("fade_out")


func _on_settings_button_pressed() -> void:
	pass # TODO: Settings UI

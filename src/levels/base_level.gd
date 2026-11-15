class_name BaseLevel
extends Node2D

@export_category("Dialog")
@export_file("*.json") var _jsonDictionary: String

@onready var dictionary = JSON.parse_string(
		FileAccess.get_file_as_string(_jsonDictionary)
	)
@onready var DialogLayer: CanvasLayer = $DialogLayer
@onready var PauseMenuLayer: CanvasLayer = $PauseMenuLayer

var _DialogScreen: DialogScreen
var _PauseMenu: PauseMenu


func _ready() -> void:
	$Cutscene.play("intro")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not is_instance_valid(_PauseMenu):
		var _PauseMenuScene: PackedScene = preload("res://ui/pause_menu/pause_menu.tscn")
		_PauseMenu = _PauseMenuScene.instantiate()
		PauseMenuLayer.add_child(_PauseMenu)


func open_dialog():
	var _DialogScene: PackedScene = preload("res://ui/dialog/dialog.tscn")
	_DialogScreen = _DialogScene.instantiate()
	
	_DialogScreen.data = dictionary
	DialogLayer.add_child(_DialogScreen)

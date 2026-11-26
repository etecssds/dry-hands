class_name BaseLevel
extends Node2D

@export_category("Dialog")
@export_file("*.json") var _jsonDictionary: String

@onready var DialogLayer: CanvasLayer = $DialogLayer
@onready var PauseMenuLayer: CanvasLayer = $PauseMenuLayer
@onready var SceneLayer: CanvasLayer = $SceneLayer

var _DialogScreen: DialogScreen
var _PauseMenu: PauseMenu


func _ready() -> void:
	GlobalInventory.playerDied.connect(restart)
	$Cutscene.play("intro")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not is_instance_valid(_PauseMenu):
		var _PauseMenuScene: PackedScene = preload("res://ui/pause_menu/pause_menu.tscn")
		_PauseMenu = _PauseMenuScene.instantiate()
		PauseMenuLayer.add_child(_PauseMenu)
		
	if event.is_action_pressed("inventory"):
		SceneLayer.visible = !SceneLayer.visible
	if event.is_action_pressed("enter"):
		open_dialog()


func open_dialog(_jsonDictionary = "res://ui/dialog/dialogs/intro.json"):
	var dictionary = JSON.parse_string(FileAccess.get_file_as_string(_jsonDictionary))
	var _DialogScene: PackedScene = preload("res://ui/dialog/dialog.tscn")
	_DialogScreen = _DialogScene.instantiate()
	
	_DialogScreen.data = dictionary
	DialogLayer.add_child(_DialogScreen)

func restart():
	GlobalInventory.restart_inventory()
	get_tree().reload_current_scene()

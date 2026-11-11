extends Node2D
class_name level1

@export_category("objects")
@export var _hud: CanvasLayer = null

const _dialogScreen: PackedScene = preload("res://ui/dialog_menu/dialogScreen.tscn")

var _newDialog: dialogScreen = _dialogScreen.instantiate()
var _jsonText = FileAccess.get_file_as_string("res://ui/dialog_menu/dialogs/dialogTest.json")
var _dictionary = JSON.parse_string(_jsonText)


func _ready() -> void:
	$Cutscene.play("intro")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter") and _newDialog._exist == false:
		_newDialog.data = _dictionary
		_newDialog._exist = true
		_hud.add_child(_newDialog)
		
	if is_instance_valid(_newDialog) == false:
		_newDialog = _dialogScreen.instantiate()

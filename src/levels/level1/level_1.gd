extends Node2D
class_name level1

@export_category("Dialog")
@export_file("*.json") var _jsonDictionary: String = "res://ui/dialog/dialogs/test_dialog.json"

@onready var _dictionary = JSON.parse_string(
    FileAccess.get_file_as_string(_jsonDictionary)
)
@onready var _dialogLayer: CanvasLayer = $DialogLayer

var _dialogScreen: PackedScene = preload("res://ui/dialog/dialog.tscn")
var _newDialog: dialogScreen = _dialogScreen.instantiate()

func _ready() -> void:
    $Cutscene.play("intro")

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("enter") and _newDialog._exist == false:
        _newDialog.data = _dictionary
        _newDialog._exist = true
        _dialogLayer.add_child(_newDialog)

    if is_instance_valid(_newDialog) == false:
        _newDialog = _dialogScreen.instantiate()

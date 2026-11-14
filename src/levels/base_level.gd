class_name BaseLevel
extends Node2D

@export_category("Dialog")
@export_file("*.json") var _jsonDictionary: String

@onready var dictionary = JSON.parse_string(
		FileAccess.get_file_as_string(_jsonDictionary)
	)
@onready var DialogLayer: CanvasLayer = $DialogLayer

var Dialog: DialogScreen


func _ready() -> void:
	$Cutscene.play("intro")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.is_action_pressed("enter") and not is_instance_valid(Dialog):
			var _DialogScreen: PackedScene = preload("res://ui/dialog/dialog.tscn")
			Dialog = _DialogScreen.instantiate()
			
			Dialog.data = dictionary
			DialogLayer.add_child(Dialog)

extends Control
class_name DialogScreen


@onready var _name: Label = $DialogBorder/Content/Text/Name
@onready var _dialog: RichTextLabel = $DialogBorder/Content/Text/Dialog
@onready var _faceSet: TextureRect = $DialogBorder/Content/FaceBorder/FaceSet

var _step: float = 0.025
var id: StringName = "start"
var data: Dictionary
var _tween: Tween


func _ready() -> void:
	if not data.is_empty():
		_initializeDialog()
		GlobalInventory.dialogOpened.emit()
		GlobalInventory.characterNode.can_move = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if _dialog.visible_ratio < 1:
			if _tween and _tween.is_valid():
				_tween.kill()
				_dialog.visible_ratio = 1
			return
		else:
			id = data[id]["next"]
			if id == "end":
				queue_free()
				GlobalInventory.dialogCLosed.emit()
				GlobalInventory.characterNode.can_move = true
				return
			_initializeDialog()


func _initializeDialog() -> void:
	_name.text = data[id].get("title", "")
	_dialog.text = data[id].get("dialog", "")
	_faceSet.texture = load(data[id].get("faceSet", ""))
	
	_dialog.visible_ratio = 0.0
	
	if _tween and _tween.is_valid():
		_tween.kill()
		
	var _duration: float = _dialog.get_total_character_count() * _step
	
	_tween = create_tween()
	_tween.tween_property(_dialog, "visible_ratio", 1.0, _duration)

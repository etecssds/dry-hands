extends Control
class_name dialogScreen


@export_category("objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceSet: TextureRect = null

var _exist: bool = false
var _step: float = 0.05
var _id : String = "start"
var data: Dictionary = {}

func _ready() -> void:
	_startDialog()
	
func _startDialog() -> void:
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceSet.texture = load(data[_id]["faceSet"]) 
	_dialog.visible_characters = 0
	while _dialog.visible_ratio <1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters +=1

		
func _process(_delta: float) -> void:
	if Input.is_action_pressed("dialog") and _dialog.visible_ratio <1:
		_step = 0.01
		return
	_step = 0.05
	
		
	if Input.is_action_just_pressed("dialog"):
		_id = data[_id]["next"]
		if _id == "end":
			_exist = false
			queue_free()
			return
			
		_startDialog()

extends Control
class_name MainMenu

func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("buttons"):
		_button.mouse_entered.connect(_on_mouse_entered.bind(_button))
		_button.mouse_exited.connect(_on_mouse_exited.bind(_button))
		_button.pressed.connect(_on_real_button_pressed.bind(_button))

	for _button in $MenuContainer/VBoxContainer.get_children():
		if _button is NinePatchRect:
			_button.mouse_entered.connect(_on_mouse_entered.bind(_button))
			_button.mouse_exited.connect(_on_mouse_exited.bind(_button))
			_button.gui_input.connect(_on_button_pressed.bind(_button))
			
func _on_mouse_entered(_button) -> void:
	_button.modulate.a = 0.5
	
func _on_mouse_exited(_button) -> void:
	_button.modulate.a = 1.0

func _on_button_pressed(_event, _button) -> void:
	if _event is InputEventMouseButton:
		if _event.button_index == 1 and _event.pressed:
			match _button.name:
				"PlayButton": 
					get_tree().change_scene_to_file("res://management/game_level.tscn")
					
				"ExitButton":
					get_tree().quit()

func _on_real_button_pressed(_button) -> void:
	match _button.name:
		"CreditsButton":
			$CreditsContainer.show()

		"QuitCreditsButton":
			$CreditsContainer.hide()

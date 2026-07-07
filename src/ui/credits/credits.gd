extends ColorRect

func _on_quit_credits_button_pressed() -> void:
    get_tree().change_scene_to_file("res://ui/main_menu/menu.tscn")

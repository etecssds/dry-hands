extends Control
class_name MainMenu

func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://levels/game_level.tscn")

func _on_exit_pressed() -> void:
    get_tree().quit()

func _on_credits_button_pressed() -> void:
    get_tree().change_scene_to_file("res://ui/credits.tscn")

func _on_settings_button_pressed() -> void:
    pass # TODO: Settings UI

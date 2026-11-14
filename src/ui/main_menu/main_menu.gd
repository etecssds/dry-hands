extends Control
class_name MainMenu

@export_category("Objects")
@export var _versionLabel: Label = null
@export var _version: String = "res://ui/main_menu/version.txt"

func _ready() -> void:
    _versionLabel.text = "Versão " + FileAccess.get_file_as_string(_version)

func _on_transition_animation_finished(_anim_name: StringName) -> void:
    $Mask.visible = false

func _on_play_pressed() -> void:
    get_tree().change_scene_to_file("res://levels/level1/level1.tscn")

func _on_exit_pressed() -> void:
    get_tree().quit()

func _on_credits_button_pressed() -> void:
    $CreditsContainer.visible = true
    $CreditsContainer/CreditsTransition.play("fade_in")
    
func _on_quit_credits_button_pressed() -> void:
    $CreditsContainer/CreditsTransition.play("fade_out")
    
func _on_credits_transition_animation_finished(anim_name: StringName) -> void:
    if anim_name == "fade_out":
        $CreditsContainer.visible = false

func _on_settings_button_pressed() -> void:
    pass # TODO: Settings UI

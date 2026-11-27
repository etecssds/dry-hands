extends CharacterBody2D

const TILE_SIZE: int = 16

@export var move_speed: float = 0.33
@export var player_node: CharacterBody2D = null

@onready var _animation: AnimationPlayer = $Animation
@onready var _sprite2D: Sprite2D = $Sprite

var _moving: bool = false


func _ready() -> void:
	if player_node:
		player_node.player_did_a_move.connect(_move_ai)
	
	_animation.play("idle_up")
	_animation.stop()


func _move_ai() -> void:
	if _moving:
		return
		
	var target_y = player_node.global_position.y - TILE_SIZE
	
	if global_position.y == target_y:
		_not_moving()
		return
		
	if target_y < global_position.y:
		var go_to_pos = Vector2(global_position.x, target_y)
		_moving = true
		
		# Toca a animação de andar
		_animation.play("walk_up")
		
		var tween = create_tween()
		tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		tween.tween_property(self, "global_position", go_to_pos, move_speed)
		tween.tween_callback(_not_moving)


func _not_moving() -> void:
	_moving = false
	_animation.play("idle_up")
	_animation.stop()

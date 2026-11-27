extends CharacterBody2D
class_name NPC

@export_category("Variables")
@export var _move_speed: float = 0.33
@export var _can_move: bool = true
@export var target_point: Node2D # Ponto (Marker2D) que o NPC vai seguir

@onready var _animation: AnimationPlayer = $Animation
@onready var _sprite2D: Sprite2D = $Sprite
@onready var _ray: RayCast2D = $RayCast

var _anim_dir: int = 0
var _direction: Vector2 = Vector2.ZERO
var _moving: bool = false
var _grid_size: int = 16
var _path_queue: Array[Vector2i] = []

func _ready() -> void:
	# Aguarda 1 frame para garantir que o PathfindingManager já leu o mapa
	await get_tree().process_frame
	if target_point:
		move_to_point(target_point.global_position)

func _physics_process(_delta: float) -> void:
	if not _can_move:
		return
	
	_process_path_movement()
	_animate()

func move_to_point(target_world_pos: Vector2) -> void:
	var path = Pathfind.get_grid_path(global_position, target_world_pos)
	print("Caminho calculado para o NPC: ", path)
	if path.size() > 1:
		path.remove_at(0)
		_path_queue = path
	else:
		print("AVISO: Caminho vazio ou NPC já está no destino!")

func _process_path_movement() -> void:
	if _moving or _path_queue.is_empty():
		_direction = Vector2.ZERO
		return
	
	var next_cell = _path_queue.front()
	var target_pos = Vector2(next_cell * _grid_size) + Vector2(_grid_size / 2.0, _grid_size / 2.0)
	_direction = (target_pos - global_position).normalized().round()
	
	if _direction != Vector2.ZERO:
		_ray.target_position = _direction * _grid_size
		_ray.force_raycast_update()
		
		if not _ray.is_colliding():
			_moving = true
			var tween = create_tween()
			tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			tween.tween_property(self, "position", position + _direction * _grid_size, _move_speed)
			tween.tween_callback(_on_step_finished)
		else:
			print("BLOQUEADO: RayCast bateu em -> ", _ray.get_collider().name)
			_path_queue.clear()
			_direction = Vector2.ZERO

func _on_step_finished() -> void:
	_moving = false
	if not _path_queue.is_empty():
		_path_queue.pop_front()

func _animate() -> void:
	if _direction != Vector2.ZERO:
		if _direction == Vector2.DOWN:
			_animation.play("walk_down")
			_anim_dir = 0
		elif _direction == Vector2.UP:
			_animation.play("walk_up")
			_anim_dir = 1
		elif _direction == Vector2.LEFT or _direction == Vector2.RIGHT:
			_animation.play("walk_side")
			_sprite2D.flip_h = (_direction == Vector2.RIGHT)
			_anim_dir = 2
	else:
		match _anim_dir:
			0: _animation.play("idle_down")
			1: _animation.play("idle_up")
			2: _animation.play("idle_side")

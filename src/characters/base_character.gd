extends CharacterBody2D
class_name BaseCharacter

@export_category("Variables")
@export var _move_speed: float = 0.33

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _sprite2D: Sprite2D

var _anim_dir: int
var _direction: Vector2
var _moving: bool
var _grid_size: int = 16

func _physics_process(_delta) -> void:
    #velocity = _direction * _move_speed
    _move()
    _animate()
    
func _move() -> void:
    if _moving:
        return
        
    #_direction = Input.get_vector(
        #"move_left", "move_right", "move_up", "move_down"
    #)
    _direction = Vector2.ZERO
    if Input.is_action_pressed("move_left"):
        _direction = Vector2.LEFT
    elif Input.is_action_pressed("move_right"):
        _direction = Vector2.RIGHT
    elif Input.is_action_pressed("move_up"):
        _direction = Vector2.UP
    elif Input.is_action_pressed("move_down"):
        _direction = Vector2.DOWN
        
    
    if _direction.x and _direction.y:
        _direction.y = 0
    
    if _direction and not _moving:
        _moving = true
        var tween = create_tween()
        tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
        tween.tween_property(self, "position", position + _direction * _grid_size, _move_speed)
        tween.tween_callback(_not_moving)

func _not_moving() -> void:
    _moving = false

func _animate() -> void:
    if _direction:
        if _direction == Vector2.DOWN:
            _animation.play("walk_down")
            _anim_dir = 0 # down
        if _direction == Vector2.UP:
            _animation.play("walk_up")
            _anim_dir = 1 # up
        if (_direction == Vector2.LEFT or _direction == Vector2.RIGHT):
            _animation.play("walk_side")
            if _direction == Vector2.LEFT:
                _sprite2D.flip_h = false
            if _direction == Vector2.RIGHT:
                _sprite2D.flip_h = true
            _anim_dir = 2 # side
    else:
        if _anim_dir == 0:
            _animation.play("idle_down")
        if _anim_dir == 1:
            _animation.play("idle_up")
        if _anim_dir == 2:
            _animation.play("idle_side")

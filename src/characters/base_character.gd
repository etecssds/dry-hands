extends CharacterBody2D
class_name BaseCharacter

@export_category("Variables")
@export var _move_speed: float = 128.0

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _sprite2D: Sprite2D

var dir: int

func _physics_process(_delta) -> void:
    _move()
    _animate()
    
func _move() -> void:
    var direction: Vector2 = Input.get_vector(
        "move_left", "move_right", "move_up", "move_down"
    )

    velocity = direction * _move_speed
    move_and_slide()

func _animate() -> void:
    if velocity:
        if velocity.y > 0:
            _animation.play("walk_down")
            dir = 0 # down
        if velocity.y < 0:
            _animation.play("walk_up")
            dir = 1 # up
        if velocity.x && not velocity.y:
            _animation.play("walk_side")
            if velocity.x < 0:
                _sprite2D.flip_h = false
            if velocity.x > 0:
                _sprite2D.flip_h = true
            dir = 2 # side
    else:
        if dir == 0:
            _animation.play("idle_down")
        if dir == 1:
            _animation.play("idle_up")
        if dir == 2:
            _animation.play("idle_side")

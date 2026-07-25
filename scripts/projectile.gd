extends Area2D

var dir: Vector2
var SPEED: float
@export var damage: float = 1
var life = 5;

func _physics_process(delta: float) -> void:
	if life == 0:
		queue_free()
	life -= 1

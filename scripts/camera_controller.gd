extends Camera2D

@onready var drac: CharacterBody2D = get_parent().get_node("Dracula")
@export var weight: float = 5.0

func _process(delta: float) -> void:
	if drac:
		global_position = global_position.lerp(Vector2(drac.global_position.x - 960, drac.global_position.y - 540), weight * delta)

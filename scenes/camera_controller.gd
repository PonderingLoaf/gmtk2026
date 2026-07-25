extends Camera2D

@onready var drac: CharacterBody2D = get_parent().get_node("Dracula")
@export var weight: float = 5.0

func _process(delta: float) -> void:
	if drac:
		global_position = global_position.lerp(drac.global_position, weight * delta)

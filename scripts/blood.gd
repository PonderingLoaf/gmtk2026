extends Area2D

@onready var game_manager: Node = $"../Camera2D/GameManager"

func _on_body_entered(body: Node2D) -> void:
	game_manager.increase_score()
	queue_free()

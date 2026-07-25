extends Node

const ENEMY = preload("uid://drnbj1wo2rvxd")
@onready var game: Node2D = $".."
@onready var dracula: CharacterBody2D = $"../Dracula"
@onready var label: Label = $Label

var score: int = 0;

func _on_timer_timeout() -> void:
	var enemy = ENEMY.instantiate()
	enemy.position = Vector2(randf_range(-2000, 2000), randf_range(-1500, 1500))
	game.add_child(enemy)

func increase_score() -> void:
	score += 1
	update_label()

func update_label():
	label.text = "Score: " + str(score)

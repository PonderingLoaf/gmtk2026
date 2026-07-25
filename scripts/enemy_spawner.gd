extends Node
const BUG = preload("uid://bis0piergkh2u")
const PITCHFORK_DUDE = preload("uid://dem75gewqpckd")

@onready var game: Node2D = $"../.."
@onready var dracula: CharacterBody2D = $"../../Dracula"
@onready var label: Label = $"../Label"
@onready var timer: Timer = $Timer

var difficulty = 1.0

var score: int = 0;

func _on_timer_timeout() -> void:
	var wave = randf_range(0, difficulty)
	if wave > 5:
		pitchfork_dude_wave()
	else:
		bug_wave()
	difficulty += 1
	timer.wait_time -= timer.wait_time / 100
	print(timer.wait_time)

func increase_score() -> void:
	score += 1
	update_label()

func update_label():
	label.text = str(score)

func bug_wave():
	for i in range(5):
		var radius = randf_range(750, 2000)
		var degrees = randf_range(0, 360)
		var angle_rad = deg_to_rad(degrees)
		var enemy = BUG.instantiate()
		enemy.position = Vector2(cos(angle_rad), sin(angle_rad)) * radius
		game.add_child(enemy)

func pitchfork_dude_wave():
	for i in range(5):
		var radius = randf_range(750, 2000)
		var degrees = randf_range(0, 360)
		var angle_rad = deg_to_rad(degrees)
		var enemy = PITCHFORK_DUDE.instantiate()
		enemy.position = Vector2(cos(angle_rad), sin(angle_rad)) * radius
		game.add_child(enemy)

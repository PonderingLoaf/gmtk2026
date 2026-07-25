extends Area2D

# test

@onready var dracula: CharacterBody2D = $"../Dracula"
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var game: Node2D = $".."
const BLOOD = preload("uid://ckpp81imw1drd")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health: float = 3
@export var damage: float = 1
@export var SPEED: float = 50
var health: float = 3

func _ready() -> void:
	health = max_health
	progress_bar.max_value = max_health
	progress_bar.value = health

func _process(delta: float) -> void:
	position.x = move_toward(position.x, dracula.position.x, delta * SPEED)
	position.y = move_toward(position.y, dracula.position.y, delta * SPEED)
	if dracula.position.x < position.x:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		health -= area.damage
		progress_bar.value = health
		if health <= 0:
			die.call_deferred()

func die():
	for i in range(randi_range(2, 5)):
		var blood = BLOOD.instantiate()
		blood.position = position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		game.add_child(blood)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("projectile"):
		dracula.take_damage(damage)

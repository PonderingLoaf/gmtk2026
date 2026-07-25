extends Area2D


@onready var attack_hitbox: CollisionShape2D = $AttackHitbox

@onready var dracula: CharacterBody2D = $"../Dracula"
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var game: Node2D = $".."
const BLOOD = preload("uid://ckpp81imw1drd")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var max_health: float = 3
@export var damage: float = 1
@export var SPEED: float = 50
var health: float = 3
@export var flip_to_face = true
@export var rotate_to_face = false
@export var rotation_speed = 5.0

var moving = true

func _ready() -> void:
	health = max_health
	progress_bar.max_value = max_health
	progress_bar.value = health

func _process(delta: float) -> void:
	if moving:
		position.x = move_toward(position.x, dracula.position.x, delta * SPEED)
		position.y = move_toward(position.y, dracula.position.y, delta * SPEED)
	if flip_to_face:
		if dracula.position.x < position.x:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	elif rotate_to_face:
		var target_angle = global_position.angle_to_point(dracula.position) + deg_to_rad(90)
		global_rotation = lerp_angle(global_rotation, target_angle, rotation_speed * delta)

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

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("attack")
	moving = false
	await animated_sprite_2d.frame == 4
	attack_hitbox.disabled = false
	await animated_sprite_2d.animation_finished
	attack_hitbox.disabled = true
	animated_sprite_2d.play("default")
	moving = true

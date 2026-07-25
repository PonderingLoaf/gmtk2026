extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var game_manager: Node = %GameManager
@onready var direction_indicator: Sprite2D = $triangle

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const PROJECTILE = preload("uid://bpfhq4ehimh53")
@onready var game: Node2D = $".."
@onready var special: Node = $Special

var facing: Vector2 = Vector2(1, 0)
@onready var timer: Timer = $Timer

var mouse_pos: Vector2 = Vector2.ZERO
var attack_direction: Vector2 = Vector2(1, 0)

@export var attack_damage = 1
@export var attack_cooldown = 0.4
@export var attack_size = 10

@export var special_bat_count = 3
@export var special_bat_damage = 2

func update_cooldown_timer():
	timer.wait_time = attack_cooldown

@onready var animated_sprite_2d: AnimatedSprite2D = $"../Camera2D/AnimatedSprite2D"
@onready var special_timer: Timer = $"../Camera2D/AnimatedSprite2D/Timer"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action2") and special_timer.is_stopped():
		special.activate(special_bat_count, special_bat_damage)
		special_timer.start()
		animated_sprite_2d.frame = 0
		animated_sprite_2d.play()

	mouse_pos = get_local_mouse_position()

	if mouse_pos.length_squared() > 0.0:
		attack_direction = mouse_pos.normalized()
	
	var direction = (mouse_pos).normalized()
	direction_indicator.position = direction * 24
	direction_indicator.look_at(mouse_pos)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action1") and timer.is_stopped():
		timer.start()
		spawn_projectile()
	var x_dir := Input.get_axis("left", "right")
	var y_dir := Input.get_axis("up", "down")
	var dir = Vector2(x_dir, y_dir)
	if dir:
		facing = dir
		velocity = dir.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if x_dir > 0:
		sprite_2d.flip_h = false
	elif x_dir < 0:
		sprite_2d.flip_h = true
	move_and_slide()

func spawn_projectile() -> void:
	var projectile = PROJECTILE.instantiate()
	projectile.position = position + attack_direction * 75
	projectile.SPEED = 700
	projectile.damage = attack_damage
	projectile.scale = Vector2(attack_size, attack_size) # Spawn the projectile at the size that can be upgraded
	projectile.look_at(get_global_mouse_position())
	projectile.rotation += PI / 2.0
	game.add_child(projectile)

signal health_changed(new_health)

func take_damage(amount: int):	
	game_manager.score -= amount
	game_manager.update_label()
	
	if game_manager.score <= 0:
		die()
	
func die():
	get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

extends Area2D

@onready var game: Node2D = $"."
@onready var dracula: CharacterBody2D = $"../Dracula"

var damage = 2;
var angle_degrees: float = 0
var rotation_speed: float = 270
var base_radius: float = 10
var spiral_speed: float = 100
var randomness: float = 15
var radius: float = 10

func _ready() -> void:
	randomize()
	rotation_speed = randf_range(180, 210)
	spiral_speed = randf_range(30, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle_degrees += rotation_speed * delta
	radius += spiral_speed * delta
	
	var angle_rad = deg_to_rad(angle_degrees)
	var spiral_offset = Vector2(cos(angle_rad), sin(angle_rad)) * radius
	
	global_position = dracula.position + spiral_offset

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()

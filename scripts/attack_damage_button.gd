extends Button

@onready var game_manager: Node = %GameManager
@onready var dracula: CharacterBody2D = %Dracula

var damages = [1, 1.5, 2, 2.5, 3, 4, 5, 6.5, 8, 10]
var costs = [10, 25, 50, 100, 200, 300, 450, 750]
var level = 0

func _ready() -> void:
	update()

func update():
	text = "Attack Damage\n" + str(damages[level]) + " -> " + str(damages[level + 1]) + "\nLevel " + str(level + 1) + "\nCost: $" + str(costs[level])

func _on_pressed() -> void:
	if game_manager.score >= costs[level]:
		game_manager.score -= costs[level]
		game_manager.update_label()
		level += 1
		dracula.attack_damage = damages[level]
		update()

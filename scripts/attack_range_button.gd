extends Button

@onready var game_manager: Node = %GameManager
@onready var dracula: CharacterBody2D = %Dracula

var sizes = [15, 17, 19, 22, 25, 28, 21, 35, 39, 45]
var costs = [10, 25, 50, 100, 200, 300, 450, 750]
var level = 0

func _ready() -> void:
	update()

func update():
	text = "Attack Size\n" + str(sizes[level]) + " -> " + str(sizes[level + 1]) + "\nLevel " + str(level + 1) + "\nCost: $" + str(costs[level])

func _on_pressed() -> void:
	if game_manager.score >= costs[level]:
		game_manager.score -= costs[level]
		game_manager.update_label()
		level += 1
		dracula.attack_size = sizes[level]
		update()

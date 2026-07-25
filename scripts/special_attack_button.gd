extends Button

@onready var game_manager: Node = %GameManager
@onready var dracula: CharacterBody2D = %Dracula

var bats = [3, 5, 9, 12, 15, 20, 25, 30, 35, 40]
var damage = [2, 3, 5, 7, 10, 14, 18, 24, 30, 40]
var costs = [10, 25, 50, 100, 200, 300, 450, 750]
var level = 0

func _ready() -> void:
	update()

# Reformats the button display
func update():
	text = "Attack Cooldown\n" + str(bats[level]) + "s -> " + str(bats[level + 1]) + "s\nLevel " + str(level + 1) + "\nCost: $" + str(costs[level])

func _on_pressed() -> void:
	if game_manager.score >= costs[level]: # checks if you can afford the upgrade
		game_manager.score -= costs[level] 
		game_manager.update_label() # update the blood display
		level += 1
		dracula.attack_cooldown = bats[level] # updates dracula's attack cooldown
		dracula.update_cooldown_timer() # updates dracula's timer node to the new cooldown time
		update()

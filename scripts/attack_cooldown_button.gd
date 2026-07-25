extends Button

@onready var game_manager: Node = %GameManager
@onready var dracula: CharacterBody2D = %Dracula

var cooldowns = [0.4, 0.36, 0.32, 0.29, 0.26, 0.23, 0.2, 0.18, 0.16, 0.14]
var costs = [10, 25, 50, 100, 200, 300, 450, 750]
var level = 0

func _ready() -> void:
	update()

# Reformats the button display
func update():
	text = "Attack Cooldown\n" + str(cooldowns[level]) + "s -> " + str(cooldowns[level + 1]) + "s\nLevel " + str(level + 1) + "\nCost: $" + str(costs[level])

func _on_pressed() -> void:
	if game_manager.score >= costs[level]: # checks if you can afford the upgrade
		game_manager.score -= costs[level] 
		game_manager.update_label() # update the blood display
		level += 1
		dracula.attack_cooldown = cooldowns[level] # updates dracula's attack cooldown
		dracula.update_cooldown_timer() # updates dracula's timer node to the new cooldown time
		update()

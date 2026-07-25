extends Node

const BAT = preload("res://scenes/bat.tscn")

@onready var game: Node2D = $"../.."
@onready var dracula: CharacterBody2D = %Dracula

var special = "bats"

func activate(amount, damage):
	if special == "bats":
		for i in range(amount):
			var bat = BAT.instantiate()
			bat.position = dracula.position
			bat.damage = damage
			game.add_child(bat)

extends Node

const BAT = preload("res://scenes/bat.tscn")

@onready var game: Node2D = $"../.."
@onready var dracula: CharacterBody2D = %Dracula

var special = "bats"

func activate():
	if special == "bats":
		for i in range(3):
			var bat = BAT.instantiate()
			bat.position = dracula.position
			game.add_child(bat)

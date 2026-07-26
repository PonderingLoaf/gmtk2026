class_name SkillNode
extends TextureButton

@export var data: SkillData 
@export var tooltip_node: Control
@onready var line: Line2D = $Line
@onready var dracula: CharacterBody2D = get_node("/root/Game/Dracula")
@onready var game_manager: Node = get_node("/root/Game/Camera2D/GameManager")

func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	add_to_group("skill_tree_nodes")
	
	if data:
		texture_normal = data.cannot_buy_texture
	update_visuals()

func update_visuals() -> void:
	if data.is_unlocked:
		texture_normal = data.unlocked_texture
	elif can_afford_and_meet_requirements():
		texture_normal = data.can_buy_texture
	else:
		texture_normal = data.cannot_buy_texture
	if line:
		if data.is_unlocked:
			line.default_color = Color("5b6ee1ff")
		elif can_afford_and_meet_requirements():
			line.default_color = Color("ffffffff")
		else:
			line.default_color = Color("ac3232ff")

func _on_pressed() -> void:
	if can_afford_and_meet_requirements():
		game_manager.decrease_score(data.blood_price)
		data.is_unlocked = true
		apply_stat_changes()
		update_visuals()
		get_tree().call_group("skill_tree_nodes", "update_visuals")

func can_afford_and_meet_requirements() -> bool:
	for req in data.requirements:
		if not req.is_unlocked:
			return false
	
	if game_manager.can_afford(data.blood_price + 1):
		return true
	else:
		return false

func apply_stat_changes() -> void:
	handle_skill_changes(data.stat_changes)

func handle_skill_changes(changes: Dictionary):
	for change in changes:
		var value = changes[change]
		if change == "bats_unlocked":
			dracula.bats_unlocked = value
		elif change == "bat_count":
			dracula.bat_count += value
		elif change == "bat_damage":
			dracula.bat_damage += value
		elif change == "sword_damage":
			dracula.attack_damage += value
		elif change == "sword_size":
			dracula.attack_size += value


func _on_mouse_entered() -> void:
	if data and tooltip_node:
		tooltip_node.display_skill(data.skill_name, data.description, data.blood_price)
		tooltip_node.show()

func _on_mouse_exited() -> void:
	if tooltip_node:
		tooltip_node.hide()

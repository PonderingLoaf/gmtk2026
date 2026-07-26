class_name SkillNode
extends TextureButton

@export var data: SkillData 
@export var tooltip_node: Control
@onready var line: Line2D = $Line

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
		data.is_unlocked = true
		apply_stat_changes()
		update_visuals()
		get_tree().call_group("skill_tree_nodes", "update_visuals") # Refresh all nodes

func can_afford_and_meet_requirements() -> bool:
	for req in data.requirements:
		if not req.is_unlocked:
			return false
	return true

func apply_stat_changes() -> void:
	pass

func _on_mouse_entered() -> void:
	if data and tooltip_node:
		tooltip_node.display_skill(data.skill_name, data.description)
		tooltip_node.show()

func _on_mouse_exited() -> void:
	if tooltip_node:
		tooltip_node.hide()

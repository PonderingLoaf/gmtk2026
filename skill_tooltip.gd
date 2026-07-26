extends PanelContainer

@onready var title_label: Label = $VBoxContainer/HBoxContainer/MarginContainer2/Title
@onready var desc_label: Label = $VBoxContainer/MarginContainer2/Description

func display_skill(skill_name: String, description: String) -> void:
	title_label.text = skill_name
	desc_label.text = description

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() + Vector2(15, 15)

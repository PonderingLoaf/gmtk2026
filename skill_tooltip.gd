extends PanelContainer

@onready var title_label: Label = $VBoxContainer/HBoxContainer/MarginContainer2/Title
@onready var desc_label: Label = $VBoxContainer/MarginContainer2/Description
@onready var cost_label: Label = $VBoxContainer/HBoxContainer/MarginContainer/Cost

func display_skill(skill_name: String, description: String, blood_price: int) -> void:
	title_label.text = skill_name
	desc_label.text = description
	cost_label.text = str(blood_price)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() + Vector2(15, 15)

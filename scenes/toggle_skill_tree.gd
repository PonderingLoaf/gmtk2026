extends Panel
@onready var skill_tree: Control = $SkillTree

func _ready() -> void:
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skill_tree"):
		toggle()


func _on_button_pressed() -> void:
	toggle()

func toggle():
	print("Pausing")
	var paused = get_tree().paused
	visible = not paused
	get_tree().paused = not paused
	skill_tree.update_all_skill_visuals()

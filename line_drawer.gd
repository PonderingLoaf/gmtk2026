# skill_tree_line_drawer.gd (Attach to the parent node of your SkillNodes)
extends Control

func _ready() -> void:
	# Wait one frame so Godot can finish sizing and placing the UI buttons
	await get_tree().process_frame
	queue_redraw()

func _draw() -> void:
	# Loop through all the skill buttons inside this parent node
	for child in get_children():
		if child is SkillNode and child.data:
			# Look at each requirement for this specific skill
			for req in child.data.requirements:
				var parent_node = find_node_by_data(req)
				
				if parent_node:
					# Calculate centers using LOCAL position, not global_position
					var start_pos = parent_node.position + (parent_node.size / 2)
					var end_pos = child.position + (child.size / 2)
					
					# Draw the line (Line thickness: 5.0)
					draw_line(start_pos, end_pos, Color.DARK_GRAY, 5.0)

# Helper function to find which UI button holds the target SkillData resource
func find_node_by_data(target_data: SkillData) -> SkillNode:
	for child in get_children():
		if child is SkillNode and child.data == target_data:
			return child
	return null

extends Control

func update_all_skill_visuals() -> void:
	_update_nodes_recursive(self)

func _update_nodes_recursive(current_node: Node) -> void:
	for child in current_node.get_children():
		if child is SkillNode:
			child.update_visuals()
		
		if child.get_child_count() > 0:
			_update_nodes_recursive(child)

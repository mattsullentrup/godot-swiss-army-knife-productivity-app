extends VBoxContainer


func _on_reset_button_pressed() -> void:
	var children : Array = get_children()
	for child : Node in children:
		child.current_button_color = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]


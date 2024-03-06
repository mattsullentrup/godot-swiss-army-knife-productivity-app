extends VBoxContainer


@export var project : PackedScene


func _on_new_project_button_pressed() -> void:
	var new_project : HBoxContainer = project.instantiate()
	add_child(new_project)


func _on_reset_button_pressed() -> void:
	var children : Array = get_children()
	for child : Node in children:
		child.current_button_color = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]

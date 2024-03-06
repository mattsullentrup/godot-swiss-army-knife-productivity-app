extends HBoxContainer


@export var task : PackedScene


func _on_reset_button_pressed() -> void:
	var children : Array = get_children()
	for child : Node in children:
		child.current_button_color = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]


func _on_new_task_button_pressed() -> void:
	var new_task: HBoxContainer = task.instantiate()
	add_child(new_task)

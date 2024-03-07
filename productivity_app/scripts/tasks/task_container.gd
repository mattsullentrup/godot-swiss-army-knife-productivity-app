extends VBoxContainer


@export var task : PackedScene
var are_children_visible := true


func _on_new_task_button_pressed() -> void:
	var new_task: HBoxContainer = task.instantiate()
	add_child(new_task)


func _on_toggle_tasks_button_pressed() -> void:
	var children : Array[Node] = get_children()
	if are_children_visible:
		for child in children:
			child.hide()
		are_children_visible = false
	else:
		for child in children:
			child.show()
		are_children_visible = true


func _on_reset_button_pressed() -> void:
	var children : Array = get_children()
	for child : Node in children:
		child.current_button_color = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]
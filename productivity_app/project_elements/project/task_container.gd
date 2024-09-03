extends VBoxContainer


@export var task: PackedScene
@export var toggle_tasks_button: Button
@export var folded_icon: CompressedTexture2D
@export var unfolded_icon: CompressedTexture2D

var are_children_visible := true


func create_new_task(_unnecessary_text: String = "") -> void:
	var new_task: Task = task.instantiate()
	add_child(new_task)
	new_task.line_edit.text_submitted.connect(create_new_task)


func _on_new_task_button_pressed() -> void:
	create_new_task()


func _on_toggle_tasks_button_pressed() -> void:
	var children: Array[Node] = get_children()
	if are_children_visible:
		for child in children:
			child.hide()
		are_children_visible = false
		toggle_tasks_button.icon = folded_icon
	else:
		for child in children:
			child.show()
		are_children_visible = true
		toggle_tasks_button.icon = unfolded_icon


func _on_reset_button_pressed() -> void:
	var children: Array = get_children()
	for child: Node in children:
		child.color_index = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]


func _on_line_edit_text_submitted(_new_text: String) -> void:
	create_new_task()

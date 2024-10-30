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


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Task


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is not Node:
		return

	var data_node: Node = data

	var node_below: Node
	for child in get_children():
		if child == node_below:
			continue

		var child_y_position: float = child.position.y + child.size.y / 2
		if child_y_position <= at_position.y:
			node_below = child
		elif child_y_position > at_position.y:
			break

	if node_below == null:
		return

	var index: int
	if node_below != null:
		index = node_below.get_index()
		index = clampi(index, 0, 100)

	move_child(data_node, index)

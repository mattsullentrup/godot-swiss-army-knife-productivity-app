extends VBoxContainer


@export var task: PackedScene
@export var toggle_tasks_button: Button
@export var folded_icon: CompressedTexture2D
@export var unfolded_icon: CompressedTexture2D

var are_children_visible := true


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Task


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is not Node: return

	var data_node: Node = data
	var task_size: float = data_node.size.y
	var child_dropped_on := _get_child_dropped_on(task_size, at_position.y)
	if child_dropped_on == null or child_dropped_on == data_node: return

	# get new index relative to child dropped on
	var new_index: int = child_dropped_on.get_index()
	var data_index: int = data_node.get_index()
	var child_y_mid_point: float = child_dropped_on.position.y + task_size / 2
	if data_index > new_index and child_y_mid_point < at_position.y:
		new_index += 1
	elif data_index < new_index and child_y_mid_point > at_position.y:
		new_index -= 1

	new_index = clampi(new_index, 0, 100)
	move_child(data_node, new_index)


func _get_child_dropped_on(task_size: float, at_position_vertical: float) -> Node:
	for child in get_children():
		if child.position.y + task_size > at_position_vertical:
			return child

	return null


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

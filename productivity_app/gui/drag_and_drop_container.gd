class_name DragAndDropContainer
extends VBoxContainer
## Parent to child to do items and manages drag and drop behaviour


const MAX_TASKS = 100

@export_enum("Project", "Task", "SubTask") var _child_type: String = "Project"

var separator: HSeparator
var task_height: float


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is not Node:
		return false

	var data_node: Node = data
	var is_child_type := _is_node_child_type(data_node)
	if not is_child_type:
		return false

	task_height = data_node.size.y
	var child_hovered_over := _get_child_under_mouse(task_height, at_position.y)
	if child_hovered_over == null:
		return is_child_type

	if separator == null:
		var other_container := data_node.get_parent() as DragAndDropContainer
		if other_container != null:
			separator = other_container.separator
			other_container.separator = null
			_reparent_node_from_different_container(separator, other_container)

	if is_child_type:
		_move_child_to_new_index(child_hovered_over, separator, at_position)

	return is_child_type


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if separator != null:
		separator.queue_free()

	if data is not Node:
		return

	var data_node: Node = data
	var child_dropped_on := _get_child_under_mouse(task_height, at_position.y)
	if child_dropped_on == null:
		return

	_reparent_node_from_different_container(
			data_node, data_node.get_parent() as DragAndDropContainer
	)
	_move_child_to_new_index(child_dropped_on, data_node, at_position)


func _reparent_node_from_different_container(
		node: Node, different_container: DragAndDropContainer
) -> void:
	if node not in get_children():
		different_container.remove_child(node)
		add_child(node)


func _move_child_to_new_index(
		child_under_mouse: Node, node_to_move: Node, at_position: Vector2
) -> void:
	var new_index: int = child_under_mouse.get_index()
	var current_index: int = node_to_move.get_index()
	var child_y_mid_point: float = child_under_mouse.position.y + task_height / 2
	if current_index > new_index and child_y_mid_point < at_position.y:
		new_index += 1
	elif current_index < new_index and child_y_mid_point > at_position.y:
		new_index -= 1

	new_index = clampi(new_index, 0, MAX_TASKS)
	move_child(node_to_move, new_index)


func _get_child_under_mouse(task_size: float, at_position_vertical: float) -> Node:
	for child in get_children():
		if child == separator:
			continue

		if child.position.y + task_size > at_position_vertical:
			return child

	return null


func _is_node_child_type(node: Node) -> bool:
	var type: StringName = node.get_script().get_global_name()
	return type == _child_type

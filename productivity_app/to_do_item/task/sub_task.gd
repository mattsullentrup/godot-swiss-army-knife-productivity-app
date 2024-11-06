class_name SubTask
extends ToDoItem


var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String

@onready var _task_state_button: Button = %TaskStateButton


func _gui_input(event: InputEvent) -> void:
	var mouse_motion := event as InputEventMouseMotion
	if mouse_motion != null:
		var is_mouse_in_rect := Rect2(Vector2(), size).has_point(get_local_mouse_position())
		if is_mouse_in_rect:
			print(_type)
		if item_hovered_over == null and is_mouse_in_rect:
			item_hovered_over = self
			accept_event()
		elif item_hovered_over == self and not is_mouse_in_rect:
			item_hovered_over = null


func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := self.duplicate() as SubTask
	if preview == null:
		return

	preview.modulate = Color(preview.modulate, 0.5)
	set_drag_preview(preview)

	#var separator: HSeparator = HSeparator.new()
	#separator.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#to_do_item.get_parent().separator = separator
	#to_do_item.get_parent().add_child(separator)

	return self


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is not Node:
		return false

	var data_node: Node = data
	var data_type: StringName = data_node.get_script().get_global_name()
	var result := data_type == _type
	return result


func save(tasks_data: Array[ToDoItemData]) -> void:
	var data := TaskData.new()

	data.text = line_edit.text
	data.color_index = color_index
	data.scene_file_path = scene_file_path

	tasks_data.append(data)


func _load() -> void:
	if _save_data is not TaskData:
		return

	line_edit.text = _save_data.text

	color_index = _save_data.color_index
	_task_state_button.theme_type_variation = button_types[color_index % 3]


func _on_task_state_button_pressed() -> void:
	color_index += 1
	_task_state_button.theme_type_variation = button_types[color_index % 3]


func _on_delete_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(new_text: String) -> void:
	text = new_text


func _on_line_edit_text_submitted(_new_text: String) -> void:
	release_focus()

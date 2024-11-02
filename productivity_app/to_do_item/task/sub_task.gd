class_name SubTask
extends ToDoItem


signal task_text_changed

var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String

@onready var _task_state_button: Button = %TaskStateButton


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
	task_text_changed.emit()

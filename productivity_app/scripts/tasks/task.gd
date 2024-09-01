class_name Task
extends HBoxContainer


signal task_text_changed

@export var _task_state_button: Button
@export var _line_edit: LineEdit

var save_data: TaskData
var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String


func _ready() -> void:
	if not save_data == null:
		_load()
		return
	_line_edit.grab_focus()

func save(tasks: Array[TaskData]) -> void:
	var task_data := TaskData.new()
	
	task_data.text = _line_edit.text
	task_data.color_index = color_index
	
	tasks.append(task_data)


func _load() -> void:
	_line_edit.text = save_data.text
	
	color_index = save_data.color_index
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

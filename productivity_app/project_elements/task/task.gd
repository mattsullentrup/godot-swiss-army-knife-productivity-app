class_name Task
extends HBoxContainer


signal task_text_changed

var save_data: TaskData
var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String

@onready var line_edit: LineEdit = %LineEdit
@onready var _task_state_button: Button = %TaskStateButton
@onready var _drag_and_drop_texture_rect: DragAndDropTextureRect = $DragAndDropTextureRect


func _ready() -> void:
	if not save_data == null:
		_load()
	else:
		line_edit.grab_focus()

	_drag_and_drop_texture_rect.task = self
	#_drag_and_drop_texture_rect.task_container = get_parent()


func save(tasks_data: Array[TaskData]) -> void:
	var data := TaskData.new()

	data.text = line_edit.text
	data.color_index = color_index
	data.scene_file_path = scene_file_path

	tasks_data.append(data)


func _load() -> void:
	line_edit.text = save_data.text

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

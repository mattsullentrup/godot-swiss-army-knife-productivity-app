class_name Task
extends ToDoItem


signal task_text_changed

var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String

@onready var _task_state_button: Button = %TaskStateButton
@onready var _task_container: VBoxContainer = %TaskContainer


func save(tasks_data: Array[TaskData]) -> void:
	var data := TaskData.new()

	data.text = line_edit.text
	data.color_index = color_index
	data.scene_file_path = scene_file_path
	var sub_tasks_data: Array[SubTaskData]
	for task in _task_container.get_children():
		task.save(sub_tasks_data)

	data.sub_tasks_data = sub_tasks_data
	tasks_data.append(data)


func _load() -> void:
	if _save_data is not TaskData:
		return

	line_edit.text = _save_data.text
	color_index = _save_data.color_index
	_task_state_button.theme_type_variation = button_types[color_index % 3]

	for sub_task_data: SubTaskData in _save_data.sub_tasks_data:
		var sub_task_scene: Resource = load(sub_task_data.scene_file_path)
		var sub_task: Node = sub_task_scene.instantiate()
		sub_task.save_data = sub_task_data
		_task_container.add_child(sub_task)
		sub_task.line_edit.text_submitted.connect(_task_container.create_new_task)


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


func _on_to_do_item_action_texture_rect_gui_input(event: InputEvent) -> void:
	var mouse_button := event as InputEventMouseButton
	if mouse_button == null: return

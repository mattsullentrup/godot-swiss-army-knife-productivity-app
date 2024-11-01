class_name Project
extends ToDoItem


@onready var _task_container: VBoxContainer = %TaskContainer


func save(projects_data: Array[ProjectData]) -> void:
	var data := ProjectData.new()

	data.scene_file_path = scene_file_path
	data.text = line_edit.text

	var tasks_data: Array[TaskData]
	for task in _task_container.get_children():
		task.save(tasks_data)

	data.tasks_data = tasks_data
	projects_data.append(data)


func _load() -> void:
	save_data = _save_data as ProjectData
	if save_data == null:
		return

	line_edit.text = save_data.text

	for task_data: TaskData in save_data.tasks_data:
		var task_scene: Resource = load(task_data.scene_file_path)
		var task: Node = task_scene.instantiate()
		task.save_data = task_data
		_task_container.add_child(task)
		task.line_edit.text_submitted.connect(_task_container.create_new_task)


func _on_delete_button_pressed() -> void:
	queue_free()

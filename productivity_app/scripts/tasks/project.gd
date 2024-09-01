class_name Project
extends VBoxContainer


var text: String

@onready var _line_edit: LineEdit = %LineEdit
@onready var _task_container: VBoxContainer = %TaskContainer


func _ready() -> void:
	_line_edit.text = text


func save(projects: Array[ProjectData]) -> void:
	var project_data := ProjectData.new()
	
	project_data.scene_file_path = scene_file_path
	
	var tasks: Array[TaskData]
	for task in _task_container.get_children():
		task.save(tasks)
	
	projects.append(project_data)


func _on_delete_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(new_text: String) -> void:
	text = new_text

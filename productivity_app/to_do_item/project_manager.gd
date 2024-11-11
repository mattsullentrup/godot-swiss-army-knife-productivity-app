extends ToDoItemContainer


@export var project: PackedScene


func _input(event: InputEvent) -> void:
	if event.is_action_released("new_task"):
		var focused_control := get_viewport().gui_get_focus_owner()
		if focused_control:
			focused_control.release_focus()
		var last_project: Project = get_child(-1)
		last_project.create_new_task()


func _on_new_project_button_pressed() -> void:
	_create_new_project()


func _create_new_project() -> void:
	var new_project: VBoxContainer = project.instantiate()
	add_child(new_project)

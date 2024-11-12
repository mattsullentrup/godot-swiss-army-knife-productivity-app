extends VBoxContainer


@export var project_scene: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	# TODO: If nothing is focused or focused node is a to do item,
	# get last task/sub_task and add new item below it
	var focused := get_viewport().gui_get_focus_owner()
	if (focused and is_ancestor_of(focused)) or get_child_count() == 0:
		return

	if event.is_action_pressed("new_task"):
		_create_lowest_task()
	elif event.is_action_pressed("new_sub_task"):
		_create_lowest_sub_task()


func _create_lowest_task() -> void:
	var last_project: Project = get_child(-1)
	last_project.create_new_task()
	get_viewport().set_input_as_handled()


func _create_lowest_sub_task() -> void:
	var children := get_children()
	children.reverse()
	for child in children:
		var task_container: VBoxContainer = child.get_node("%TaskContainer")
		if task_container.get_child_count() == 0:
			continue

		var last_task: Task = task_container.get_child(-1)
		last_task.create_new_task()

	get_viewport().set_input_as_handled()


func _on_new_project_button_pressed() -> void:
	_create_new_project()


func _create_new_project() -> void:
	var new_project: VBoxContainer = project_scene.instantiate()
	add_child(new_project)

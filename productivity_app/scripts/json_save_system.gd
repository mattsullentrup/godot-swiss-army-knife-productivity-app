extends Node


signal game_saved

const SAVE_PATH = "user://save_json.json"

@export var project_manager_node: NodePath


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()
		await game_saved
		print("game saved")
	elif what == NOTIFICATION_ENTER_TREE:
		_load()


func _save() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var save_dict: Dictionary = {
		projects = []
	}

	for project in get_tree().get_nodes_in_group(&"Project"):
		var task_container: VBoxContainer = project.get_node_or_null("TaskContainer")
		var tasks: Array[Node] = task_container.get_children()

		save_dict.projects.push_back({
			text = var_to_str(project.text),
			children = var_to_str(tasks),
		})

	file.store_line(JSON.stringify(save_dict))


func _load() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("save file does not exist")
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	while file.get_position() < file.get_length():
		var json := JSON.new()
		var parse_result: Error = json.parse(file.get_line())

		if not parse_result == OK:
			print(
					"JSON Parse Error: ", json.get_error_message(), " in ", file, " at line ",
					json.get_error_line()
			)
			continue

		var save_dict: Variant = json.get_data()
		var project_manager: VBoxContainer = get_node(project_manager_node)

		get_tree().call_group("Project", "queue_free")

		if save_dict is not Dictionary or save_dict.projects == null:
			return

		for saved_project: Variant in save_dict.projects:
			var new_project := preload("res://scenes/project.tscn").instantiate() as Project
			new_project.text = saved_project.text
			project_manager.add_child(new_project)

			#var task_container: VBoxContainer = new_project.get_node_or_null("TaskContainer")
			#var saved_project_children: String = saved_project.children
			#for child: Task in str_to_var(saved_project_children):
				#var task := preload("res://scenes/task.tscn").instantiate() as Task
				#task.current_button_color = child.current_button_color
				#task.text = child.text
				#task_container.add_child(task)

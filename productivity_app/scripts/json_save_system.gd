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

	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict: Dictionary = {
		projects = []
	}

	for project in get_tree().get_nodes_in_group(&"project"):
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
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary
	var project_manager: VBoxContainer = get_node(project_manager_node)

	# Remove existing enemies before adding new ones.
	get_tree().call_group("project", "queue_free")

	if save_dict.projects == null:
		return

	for project_config: Variant in save_dict.projects:
		var project := preload("res://scenes/project.tscn").instantiate() as Project
		project.text = str_to_var(project_config.text)
		project_manager.add_child(project)

		var task_container: VBoxContainer = project.get_node_or_null("TaskContainer")

		for child: Task in str_to_var(project_config.children):
			var task := preload("res://scenes/task.tscn").instantiate() as Task
			task.current_button_color = child.current_button_color
			task.text = child.text
			task_container.add_child(task)
			#task.task_text_changed.connect(save_game)

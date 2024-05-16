extends Node



const SAVE_PATH = "user://save_config_file.ini"

## The task manager node (so we can get and instance tasks).
@export var project_manager_node: NodePath
## The pomodoro node (so we can set/get its state and round).
@export var pomodoro_node: NodePath


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
	elif what == NOTIFICATION_ENTER_TREE:
		load_game()


func save_game() -> void:
	var config := ConfigFile.new()

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	config.set_value("pomodoro", "current_round", pomodoro.current_round)
	config.set_value("pomodoro", "productivity_state", pomodoro.productivity_state)

	var projects := []
	for project in get_tree().get_nodes_in_group(&"persist"):
		var task_container: VBoxContainer = project.get_node_or_null("TaskContainer")
		var tasks: Array[Node] = task_container.get_children()

		projects.push_back({
			text = project.text,
			children = tasks,
		})

	config.set_value("projects", "projects", projects)

	config.save(SAVE_PATH)


func load_game() -> void:
	var config := ConfigFile.new()
	config.load(SAVE_PATH)

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	pomodoro.current_round = config.get_value("pomodoro", "current_round")
	pomodoro.productivity_state = config.get_value("pomodoro", "productivity_state")

	# Remove existing projects before adding new ones.
	get_tree().call_group("persist", "queue_free")
	load_projects(config)


func load_projects(config: ConfigFile) -> void:
	var projects: Variant = config.get_value("projects", "projects")

	var project_manager: VBoxContainer = get_node(project_manager_node)

	if projects == null:
		return

	for project_config: Variant in projects:
		var project := preload("res://scenes/project.tscn").instantiate() as Project
		project.text = project_config.text
		project_manager.add_child(project)

		var task_container: VBoxContainer = project.get_node_or_null("TaskContainer")
		for child: Task in project_config.children:
			var task := preload("res://scenes/task.tscn").instantiate() as Task
			task.current_button_color = child.current_button_color
			task.text = child.text
			task_container.add_child(task)
			task.task_text_changed.connect(save_game)

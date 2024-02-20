extends Node


const SAVE_PATH = "user://save_config_file.ini"

## The root game node (so we can get and instance enemies).
@export var task_node: NodePath
## The player node (so we can set/get its health and position).
@export var pomodoro_node: NodePath


func save_game() -> void:
	var config := ConfigFile.new()

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	config.set_value("pomodoro", "current_state", pomodoro.current_state)
	config.set_value("pomodoro", "current_round", pomodoro.current_round)
	config.set_value("pomodoro", "productivity_state", pomodoro.productivity_state)

	var tasks := []
	for task in get_tree().get_nodes_in_group(&"task"):
		tasks.push_back({
			position = task.position,
		})
	config.set_value("tasks", "tasks", tasks)

	config.save(SAVE_PATH)

	#(get_node(^"../LoadConfigFile") as Button).disabled = false


func load_game() -> void:
	var config := ConfigFile.new()
	config.load(SAVE_PATH)

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	pomodoro.current_state = config.get_value("pomodoro", "current_state")
	pomodoro.current_round = config.get_value("pomodoro", "current_round")
	pomodoro.productivity_state = config.get_value("pomodoro", "productivity_state")

	# Remove existing enemies before adding new ones.
	get_tree().call_group("task", "queue_free")

	var tasks = config.get_value("tasks", "tasks")
	var task_manager : PanelContainer = get_node(task_node)

	for task_config : Task in tasks:
		var task := preload("res://scenes/task.tscn").instantiate() as Task
		#enemy.position = enemy_config.position
		task_manager.add_child(task)




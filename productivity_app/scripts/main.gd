extends Node


const SAVE_PATH = "user://save_config_file.ini"

## The task manager node (so we can get and instance tasks).
@export var task_manager_node: NodePath
## The pomodoro node (so we can set/get its state and round).
@export var pomodoro_node: NodePath


func _ready() -> void:
	load_game()
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		save_and_quit()


func _notification(what : int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_and_quit()
	elif what == NOTIFICATION_ENTER_TREE:
		load_game()


func save_and_quit() -> void:
	save_game()
	get_tree().quit()


func save_game() -> void:
	var config := ConfigFile.new()

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	#config.set_value("pomodoro", "current_state", pomodoro.current_state)
	config.set_value("pomodoro", "current_round", pomodoro.current_round)
	config.set_value("pomodoro", "productivity_state", pomodoro.productivity_state)

	var tasks := []
	for task in get_tree().get_nodes_in_group(&"task"):
		tasks.push_back({
			current_button_color = task.current_button_color,
			text = task.text
		})

	config.set_value("tasks", "tasks", tasks)
	config.save(SAVE_PATH)


func load_game() -> void:
	var config := ConfigFile.new()
	config.load(SAVE_PATH)

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	#pomodoro.current_state = config.get_value("pomodoro", "current_state")
	pomodoro.current_round = config.get_value("pomodoro", "current_round")
	pomodoro.productivity_state = config.get_value("pomodoro", "productivity_state")

	# Remove existing tasks before adding new ones.
	get_tree().call_group("task", "queue_free")

	var tasks : Variant = config.get_value("tasks", "tasks")
	var task_manager : VBoxContainer = get_node(task_manager_node)

	for task_config : Variant in tasks:
		var task := preload("res://scenes/task.tscn").instantiate() as Task
		task.current_button_color = task_config.current_button_color
		task.text = task_config.text
		task_manager.add_child(task)

extends Node


const SAVE_PATH = "user://save_json.json"

## The task manager node (so we can get and instance tasks).
@export var task_manager_node: NodePath
## The pomodoro node (so we can set/get its state and round).
@export var pomodoro_node: NodePath


func _ready() -> void:
	#load_game()
	return


func _notification(what : int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
	elif what == NOTIFICATION_ENTER_TREE:
		#load_game()
		return


func save_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	# JSON doesn't support many of Godot's types such as Vector2.
	# var_to_str can be used to convert any Variant to a String.
	var save_dict := {
		pomodoro = {
			current_round = var_to_str(pomodoro.current_round),
			productivity_state = var_to_str(pomodoro.productivity_state)
		},
		projects = []
	}

	#for project in get_tree().get_nodes_in_group(&"project"):
	#	save_dict.projects.push_back({
	#		text = var_to_str(project.text),
	#	})

	file.store_line(JSON.stringify(save_dict))

	get_node(^"../LoadJSON").disabled = false


func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict := json.get_data() as Dictionary

	var pomodoro := get_node(pomodoro_node) as Pomodoro
	# JSON doesn't support many of Godot's types such as Vector2.
	# str_to_var can be used to convert a String to the corresponding Variant.
	pomodoro.current_round = str_to_var(save_dict.pomodoro.current_round)
	pomodoro.productivity_state = str_to_var(save_dict.pomodoro.productivity_state)

	# Remove existing enemies before adding new ones.
	#get_tree().call_group("project", "queue_free")

	## Ensure the node structure is the same when loading.
	#var task_manager := get_node(task_manager_node)

	#for project_config in save_dict.projects:
	#	var project : Project = preload("res://scenes/project.tscn").instantiate() as Project
	#	project.text = str_to_var(project_config.text)
	#	task_manager.add_child(project)

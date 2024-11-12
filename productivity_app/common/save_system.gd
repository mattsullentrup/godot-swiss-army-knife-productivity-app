class_name SaveSystem
extends Node

#TODO: add save values for pomodoro timer current state and time remaining


signal game_saved

# Use different save files for editor and exported project to prevent breaking
# my local save for everyday use
const USER_SAVE_PATH = "user://save.tres"
const EDITOR_SAVE_PATH = "res://editor_save/save.tres"

var is_game_saved := false

@onready var _project_manager: VBoxContainer = %ProjectManager


func _ready() -> void:
	_load()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()


func _save() -> void:
	var save_file := SaveFile.new()
	var projects_data: Array[ToDoItemData]

	get_tree().call_group("Project", "save", projects_data)
	save_file.projects_data.assign(projects_data)

	var save_path := _get_save_path()
	ResourceSaver.save(save_file, save_path)

	is_game_saved = true
	game_saved.emit()


func _load() -> void:
	var save_path := _get_save_path()
	if not FileAccess.file_exists(save_path):
		return

	var save_file := load(save_path) as SaveFile
	if save_file == null:
		return

	for project_data in save_file.projects_data:
		var project_scene_path: Resource = load(project_data.scene_file_path)
		if project_scene_path == null:
			return

		var project: Node = project_scene_path.instantiate()
		project.save_data = project_data
		_project_manager.add_child(project)


func _get_save_path() -> String:
	return EDITOR_SAVE_PATH if OS.has_feature("editor") else USER_SAVE_PATH

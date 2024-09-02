class_name SaveSystem
extends Node


const SAVE_PATH = "user://save.tres"

@onready var _project_manager: VBoxContainer = %ProjectManager


func _ready() -> void:
	_load()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save()


func _save() -> void:
	var save_file := SaveFile.new()
	var projects_data: Array[ProjectData]
	
	get_tree().call_group("Project", "save", projects_data)
	
	save_file.projects_data = projects_data
	
	ResourceSaver.save(save_file, SAVE_PATH)


func _load() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var save_file := load(SAVE_PATH) as SaveFile

	if save_file == null:
		return
	
	for project_data in save_file.projects_data:
		var project_scene_path: Resource = load(project_data.scene_file_path)
		if project_scene_path == null:
			return
		var project: Node = project_scene_path.instantiate()
		
		project.save_data = project_data
		
		_project_manager.add_child(project)

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
	var projects: Array[ProjectData]
	
	get_tree().call_group("Project", "save", projects)
	
	save_file.projects = projects
	
	ResourceSaver.save(save_file, SAVE_PATH)


func _load() -> void:
	pass

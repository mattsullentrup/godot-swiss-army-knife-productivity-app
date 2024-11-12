extends Node


const USER_FILE_PATH = "user://settings.cfg"
const EDITOR_FILE_PATH = "res://editor_save/settings.cfg"

const SETTINGS_SECTION = "settings"

const BREAK_REMINDER = "break_reminder"
const BREAK_REMINDER_DEFAULT = false

const REMINDER_INTERVAL = "reminder_interval"
const REMINDER_INTERVAL_DEFAULT = 5


@onready var _config_file := ConfigFile.new()


func _ready() -> void:
	_load_settings()


func get_value(key: String, default_value: Variant = null) -> Variant:
	return _config_file.get_value(SETTINGS_SECTION, key, default_value)


func set_value(key: String, value: Variant = null) -> void:
	_config_file.set_value(SETTINGS_SECTION, key, value)
	_save_settings()


func _load_settings() -> int:
	var err := _config_file.load(_get_file_path())
	if err == ERR_FILE_NOT_FOUND:
		pass
	elif err != OK:
		printerr("Failed to load settings file")

	return err


func _save_settings() -> int:
	var err := _config_file.save(_get_file_path())
	if err == ERR_FILE_NOT_FOUND:
		pass
	elif err != OK:
		printerr("Failed to save settings file")

	return err


func _get_file_path() -> String:
	return EDITOR_FILE_PATH if OS.has_feature("editor") else USER_FILE_PATH

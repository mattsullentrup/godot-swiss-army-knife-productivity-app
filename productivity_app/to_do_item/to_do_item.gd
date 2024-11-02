class_name ToDoItem
extends Container


var new_save_data: ToDoItemData
var save_data: ToDoItemData:
	get:
		return _save_data
	set(value):
		_save_data = value

var _save_data: ToDoItemData

@onready var line_edit: LineEdit = %LineEdit
@onready var _to_do_item_action_texture_rect: ToDoItemActionTextureRect = %ToDoItemActionTextureRect


func _ready() -> void:
	if not _save_data == null:
		_load()
	else:
		line_edit.grab_focus()

	_to_do_item_action_texture_rect.to_do_item = self


func save(_data: Array) -> void:
	return


func _load() -> void:
	return

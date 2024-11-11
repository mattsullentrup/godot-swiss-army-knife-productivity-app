class_name ToDoItem
extends Container


static var item_hovered_over: ToDoItem

var new_save_data: ToDoItemData
var save_data: ToDoItemData:
	get:
		return _save_data
	set(value):
		_save_data = value

var _save_data: ToDoItemData

@onready var line_edit: LineEdit = %LineEdit


func _ready() -> void:
	if not _save_data == null:
		_load()


func save(_data: Array) -> void:
	return


func _load() -> void:
	return

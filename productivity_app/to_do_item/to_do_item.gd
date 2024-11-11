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
	line_edit.text_changed.connect(_on_line_edit_text_changed)
	if not _save_data == null:
		_load()
	else:
		line_edit.grab_focus()


func save(_data: Array) -> void:
	return


func _load() -> void:
	return


func _on_line_edit_text_changed(new_text: String = "") -> void:
	if Input.is_key_pressed(KEY_CTRL):
		line_edit.text.trim_suffix(new_text)
		#var f = line_edit.text.erase(-new_text.length(), new_text.length())
		pass

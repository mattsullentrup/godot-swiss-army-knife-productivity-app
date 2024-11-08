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
@onready var _to_do_item_action_texture_rect: ToDoItemActionTextureRect = %ToDoItemActionTextureRect
@onready var _type: StringName = get_script().get_global_name()


func _ready() -> void:
	if not _save_data == null:
		_load()
	else:
		line_edit.grab_focus()

	_to_do_item_action_texture_rect.to_do_item = self
	mouse_exited.connect(_on_mouse_exited)


func save(_data: Array) -> void:
	return


func _load() -> void:
	return


func _try_drop(at_position: Vector2, data: Variant) -> void:
	pass


func _on_mouse_exited() -> void:
	if not Rect2(Vector2(), size).has_point(get_local_mouse_position()) and item_hovered_over == self:
		if _type == "SubTask":
			pass
		item_hovered_over = null

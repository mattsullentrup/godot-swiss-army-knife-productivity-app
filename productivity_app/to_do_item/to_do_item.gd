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

	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)

#func _process(delta: float) -> void:
	#print(item_hovered_over)

	#if not item_hovered_over == null and is_ancestor_of(item_hovered_over):
		#return
#
	#var is_mouse_in_rect := Rect2(Vector2(), size).has_point(get_local_mouse_position())
#
	#if item_hovered_over == null and is_mouse_in_rect:
		#item_hovered_over = self
	#if item_hovered_over == self and not is_mouse_in_rect:
		#item_hovered_over = null





func save(_data: Array) -> void:
	return


func _load() -> void:
	return

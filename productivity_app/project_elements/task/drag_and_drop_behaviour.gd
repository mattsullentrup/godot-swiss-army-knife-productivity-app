class_name DragAndDropBehaviour
extends TextureRect


signal task_dropped(at_position: Vector2, data: Variant)

var task: Task
var task_container: Control
## TODO: store vertical size on startup to calculate midpoint
@onready var mid_point := size.y / 2


#func _ready() -> void:
	#gui_input.connect(_on_gui_input)
#
#
#func _on_gui_input(event: InputEvent) -> void:
	#var button := event as InputEventMouseButton
	#if button == null or button.button_index != MOUSE_BUTTON_LEFT:
		#return
#
	#if button.pressed and ancestor_rect == NULL_RECT:
		#ancestor_rect = task_container.get_parent_control().get_global_rect()
		#ancestor_start_y = ancestor_rect.position.y
		#ancestor_end_y = ancestor_rect.end.y
		#printt(ancestor_start_y, ancestor_end_y)


func _get_drag_data(at_position: Vector2) -> Variant:
	#var preview = self.duplicate()
	var preview = task.duplicate()
	set_drag_preview(preview)
	print(preview)
	return task


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Task


func _drop_data(at_position: Vector2, data: Variant) -> void:
	printt(at_position, data.position, task.position)
	var index := task.get_index()
	if at_position.y >= mid_point:
		task_container.move_child(data, index)
	else:
		var new_index := index - 1
		new_index = clampi(new_index, 0, 100)
		task_container.move_child(data, new_index)

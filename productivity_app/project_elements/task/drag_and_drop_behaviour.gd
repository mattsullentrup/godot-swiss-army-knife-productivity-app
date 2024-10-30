class_name DragAndDropBehaviour
extends TextureRect


#signal task_dropped(at_position: Vector2, data: Variant)

var task: Task
var task_container: Control
@onready var mid_point := size.y / 2


func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := task.duplicate() as Task
	if preview == null: return

	preview.modulate = Color(preview.modulate, 0.5)
	set_drag_preview(preview)
	return task


#func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	#return data is Task
#
#
#func _drop_data(at_position: Vector2, data: Variant) -> void:
	#if data is not Node:
		#return
#
	#var node: Node = data
#
	#var index := task.get_index()
	#if at_position.y >= mid_point:
		#task_container.move_child(node, index)
	#else:
		#var new_index := index - 1
		#new_index = clampi(new_index, 0, 100)
		#task_container.move_child(node, new_index)

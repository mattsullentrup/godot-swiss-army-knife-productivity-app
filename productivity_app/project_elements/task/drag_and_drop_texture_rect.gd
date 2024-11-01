class_name DragAndDropTextureRect
extends TextureRect


var task: Task
#var task_container: VBoxContainer


func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := task.duplicate() as Task
	if preview == null: return

	preview.modulate = Color(preview.modulate, 0.5)
	set_drag_preview(preview)
	var separator: HSeparator = HSeparator.new()
	separator.mouse_filter = Control.MOUSE_FILTER_IGNORE
	task.get_parent().separator = separator
	task.get_parent().add_child(separator)
	return task

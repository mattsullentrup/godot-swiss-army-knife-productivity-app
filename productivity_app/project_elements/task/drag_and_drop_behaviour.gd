class_name DragAndDropBehaviour
extends TextureRect


var task: Task


func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := task.duplicate() as Task
	if preview == null: return

	preview.modulate = Color(preview.modulate, 0.5)
	set_drag_preview(preview)
	return task

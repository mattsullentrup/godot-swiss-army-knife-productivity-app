class_name DragAndDropBehaviour
extends TextureRect


signal task_dropped(at_position: Vector2, data: Variant)

var task: Task
var task_container: Control
## TODO: store vertical size on startup to calculate midpoint


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
	#print(task)
	return true


func _drop_data(at_position: Vector2, data: Variant) -> void:
	### TODO: Fix dragged node being replaced by node dragged over
	#var node_below: Node
	#for child in task_container.get_children():
		#if child == task:
			#continue
#
		#var pos = child.position.y
		#var task_pos = task.position.y
		#if child.position.y < task.position.y:
			#node_below = child
		#elif child.position.y > task.position.y:
			#break
#
	#var index: int
	#if node_below != null:
		#index = node_below.get_index()
#
	#task_container.move_child(task, index)

	printt(at_position, data.position, task.position)
	## TODO: call move child on task container depending on data position relative to midpoint

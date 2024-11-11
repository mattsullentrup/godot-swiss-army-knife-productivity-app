extends DragAndDropContainer


@export var project: PackedScene


func _gui_input(event: InputEvent) -> void:
	var mouse := event as InputEventMouseMotion
	if mouse == null:
		return

	var item := ToDoItem.item_hovered_over
	if item == null:
		return

	var item_mouse_pos := item.get_local_mouse_position()

	#NOTE: This doesn't work but I'm trying to make it so if the mouse is in the gap between tasks
	# it doesn't stop being the hovered item for those few pixels
	# This is so fuckin stupid there's gotta be a better way to deal with this
	if not Rect2(Vector2(0, -5), Vector2(item.size.x, item.size.y + 5)).has_point(item_mouse_pos):
		ToDoItem.item_hovered_over = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("new_project"):
		_create_new_project()


func _on_new_project_button_pressed() -> void:
	_create_new_project()


func _create_new_project() -> void:
	var new_project: VBoxContainer = project.instantiate()
	add_child(new_project)


func _on_mouse_exited() -> void:
	if not Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		#ToDoItem.item_hovered_over = null
		print("mouse exited")
		#child_hovered_over = null
		#if separator.is_inside_tree():
			#separator.get_parent().remove_child(separator)

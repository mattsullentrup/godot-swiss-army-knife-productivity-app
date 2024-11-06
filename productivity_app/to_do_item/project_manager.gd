extends DragAndDropContainer


@export var project: PackedScene


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
		pass
		#print("mouse exited")
		#child_hovered_over = null
		#if separator.is_inside_tree():
			#separator.get_parent().remove_child(separator)

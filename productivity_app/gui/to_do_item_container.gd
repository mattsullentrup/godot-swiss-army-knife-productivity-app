class_name ToDoItemContainer
extends VBoxContainer
## Parent to child to do items


@export var new_item_button: Button


func _unhandled_input(event: InputEvent) -> void:
	# TODO: Finish ability to add new task or sub task if this is the currently focused container.
	# Every to do item text submitted signal is hooked up so that it's parent ToDoItemContainer grabs focus
	if event.is_action_released("new_task") and get_viewport().gui_get_focus_owner() == self:
		var last_project: Project = get_child(-1)
		last_project.create_new_task()
		get_viewport().set_input_as_handled()

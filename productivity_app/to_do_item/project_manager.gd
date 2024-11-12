extends ToDoItemContainer


@export var project: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	# TODO: If nothing is focused or focused node is not a to do item,
	# get last task/sub_task and add new item below it
	#super(event)
	var focused := get_viewport().gui_get_focus_owner()
	if focused and not is_ancestor_of(focused):
		return

	if event.is_action_pressed("new_task"):
		pass
	if event.is_action_pressed("new_sub_task"):
		pass

func _process(_delta: float) -> void:
	var focused := get_viewport().gui_get_focus_owner()
	if focused:
		print(focused)


func _on_new_project_button_pressed() -> void:
	_create_new_project()


func _create_new_project() -> void:
	var new_project: VBoxContainer = project.instantiate()
	add_child(new_project)

extends ToDoItemContainer


@export var project: PackedScene


func _on_new_project_button_pressed() -> void:
	_create_new_project()


func _create_new_project() -> void:
	var new_project: VBoxContainer = project.instantiate()
	add_child(new_project)

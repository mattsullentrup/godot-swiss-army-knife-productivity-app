class_name Project
extends ToDoItemParent


func _enter_tree() -> void:
	%LineEdit.text_submitted.connect(func(_s: String) -> void: %NewTaskButton.grab_focus())


func save(projects_data: Array[ToDoItemData]) -> void:
	new_save_data = ProjectData.new()
	super(projects_data)

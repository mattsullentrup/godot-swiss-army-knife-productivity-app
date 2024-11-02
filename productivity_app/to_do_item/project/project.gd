class_name Project
extends ToDoItemParent


func save(projects_data: Array[ToDoItemData]) -> void:
	new_save_data = ProjectData.new()
	super(projects_data)

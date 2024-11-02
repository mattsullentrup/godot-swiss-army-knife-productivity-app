class_name ToDoItemParent
extends ToDoItem


const FOLDED_ICON = preload("res://addons/images/kenney_icons/right.png")
const UNFOLDED_ICON = preload("res://addons/images/kenney_icons/down.png")

#@export var task: PackedScene
@export var toggle_tasks_button: Button

var are_children_visible := true

@onready var _task_container: VBoxContainer = %TaskContainer


func save(data: Array[ToDoItemData]) -> void:
	new_save_data.scene_file_path = scene_file_path
	new_save_data.text = line_edit.text

	var tasks_data: Array[ToDoItemData]
	for task in _task_container.get_children():
		task.save(tasks_data)

	new_save_data.tasks_data.assign(tasks_data)
	data.append(new_save_data)


func _load() -> void:
	if save_data is not ToDoItemData:
		return

	line_edit.text = save_data.text

	for task_data: TaskData in save_data.tasks_data:
		var task_scene: Resource = load(task_data.scene_file_path)
		var task: Node = task_scene.instantiate()
		task.save_data = task_data
		_task_container.add_child(task)
		task.line_edit.text_submitted.connect(_task_container.create_new_task)


func _on_delete_button_pressed() -> void:
	queue_free()


func _on_to_do_item_action_texture_rect_gui_input(event: InputEvent) -> void:
	var mouse_button := event as InputEventMouseButton
	if mouse_button == null: return


#region Task management
#func create_new_task(_unnecessary_text: String = "") -> void:
	#var new_task: ToDoItem = task.instantiate()
	#add_child(new_task)
	#new_task.line_edit.text_submitted.connect(create_new_task)
#
#
#func _on_new_task_button_pressed() -> void:
	#create_new_task()
#
#
#func _on_toggle_tasks_button_pressed() -> void:
	#var children: Array[Node] = get_children()
	#if are_children_visible:
		#for child in children:
			#child.hide()
		#are_children_visible = false
		#toggle_tasks_button.icon = FOLDED_ICON
	#else:
		#for child in children:
			#child.show()
		#are_children_visible = true
		#toggle_tasks_button.icon = UNFOLDED_ICON
#
#
#func _on_reset_button_pressed() -> void:
	#var children: Array = get_children()
	#for child: Node in children:
		#child.color_index = 0
		#child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]
#
#
#func _on_line_edit_text_submitted(_new_text: String) -> void:
	#create_new_task()
#endregion

class_name ToDoItemParent
extends ToDoItem


const FOLDED_ICON = preload("res://addons/images/kenney_icons/right.png")
const UNFOLDED_ICON = preload("res://addons/images/kenney_icons/down.png")
const MAX_CHILD_TASKS = 100

@export var _child_task_scene: PackedScene

var _are_children_visible := true

@onready var _task_container: VBoxContainer = %TaskContainer
@onready var _toggle_tasks_button: Button = %ToggleTasksButton
@onready var _new_task_button: Button = %NewTaskButton
@onready var _reset_button: Button = %ResetButton
@onready var _delete_button: Button = %DeleteButton


func _ready() -> void:
	super()

	line_edit.text_submitted.connect(create_new_task)
	_new_task_button.pressed.connect(create_new_task)
	_toggle_tasks_button.pressed.connect(_on_toggle_tasks_button_pressed)
	_reset_button.pressed.connect(_on_reset_button_pressed)
	_delete_button.pressed.connect(func() -> void: queue_free())


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
		if self is Task:
			task.line_edit.text_submitted.connect(create_new_task)


func create_new_task(_text: String = "") -> void:
	var new_task: ToDoItem = _child_task_scene.instantiate()
	_task_container.add_child(new_task)
	if self is Task:
		new_task.line_edit.text_submitted.connect(create_new_task)


func _on_toggle_tasks_button_pressed() -> void:
	var children: Array[Node] = _task_container.get_children()
	if _are_children_visible:
		for child in children:
			child.hide()

		_are_children_visible = false
		_toggle_tasks_button.icon = FOLDED_ICON
	else:
		for child in children:
			child.show()

		_are_children_visible = true
		_toggle_tasks_button.icon = UNFOLDED_ICON


func _on_reset_button_pressed() -> void:
	var children: Array = _task_container.get_children()
	for child: Node in children:
		child.color_index = 0
		child.get_node("TaskStateButton").theme_type_variation = child.button_types[0]
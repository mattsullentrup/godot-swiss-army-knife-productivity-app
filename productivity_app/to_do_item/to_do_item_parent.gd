class_name ToDoItemParent
extends ToDoItem


const FOLDED_ICON = preload("res://addons/images/kenney_icons/right.png")
const UNFOLDED_ICON = preload("res://addons/images/kenney_icons/down.png")
const MAX_CHILD_TASKS = 100

@export var _child_task_scene: PackedScene
@export_enum("new_task", "new_sub_task") var _shortcut: String

var _are_children_visible := true

@onready var _task_container: VBoxContainer = %TaskContainer
@onready var _toggle_tasks_button: Button = %ToggleTasksButton


func _ready() -> void:
	super()

	_toggle_tasks_button.pressed.connect(_on_toggle_tasks_button_pressed)
	%NewTaskButton.pressed.connect(create_new_task)
	%ResetButton.pressed.connect(_on_reset_button_pressed)
	%DeleteButton.pressed.connect(func() -> void: queue_free())


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed(_shortcut):
		return

	var focused := get_viewport().gui_get_focus_owner()
	if focused and is_ancestor_of(focused):
		create_new_task()
		get_viewport().set_input_as_handled()


func create_new_task(_text: String = "") -> void:
	var new_task: ToDoItem = _child_task_scene.instantiate()
	_task_container.add_child(new_task)
	Util.setup_child_buttons_focus(new_task)


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
		child.get_node("%TaskStateButton").theme_type_variation = child.button_types[0]

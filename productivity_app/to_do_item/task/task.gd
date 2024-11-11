class_name Task
extends ToDoItemParent


var color_index: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String

@onready var _task_state_button: Button = %TaskStateButton


func _ready() -> void:
	super()
	%TaskStateButton.pressed.connect(_on_task_state_button_pressed)


func save(tasks_data: Array[ToDoItemData]) -> void:
	new_save_data = TaskData.new()
	new_save_data.color_index = color_index
	super(tasks_data)


func _load() -> void:
	super()
	color_index = _save_data.color_index
	_task_state_button.theme_type_variation = button_types[color_index % 3]


func _on_task_state_button_pressed() -> void:
	color_index += 1
	_task_state_button.theme_type_variation = button_types[color_index % 3]


func _on_line_edit_text_changed(new_text: String) -> void:
	text = new_text


#func _on_line_edit_text_submitted(_new_text: String) -> void:
	#release_focus()

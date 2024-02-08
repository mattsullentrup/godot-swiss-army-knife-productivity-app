extends PanelContainer


@export var task : PackedScene

#@onready var button_colors : Array[Color] = [Color.RED, Color.YELLOW, Color.GREEN]
@onready var button_colors : Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
@onready var current_button_color : int = 1


func _on_task_button_pressed(button: Button) -> void:
	button.theme_type_variation = button_colors[current_button_color % 3]
	current_button_color += 1


func _on_new_task_button_pressed() -> void:
	var new_task : HBoxContainer = task.instantiate()
	var task_button : Button = new_task.get_child(0)

	task_button.theme_type_variation = button_colors[0]
	task_button.pressed.connect(_on_task_button_pressed.bind(task_button))

	var delete_button : Button = new_task.get_child(2)
	delete_button.pressed.connect(_on_delete_button_pressed.bind(delete_button))

	$TaskVBoxContainer.add_child(new_task)


func _on_delete_button_pressed(button: Button) -> void:
	button.get_parent().queue_free()

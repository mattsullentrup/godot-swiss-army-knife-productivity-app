class_name Task
extends HBoxContainer


@export var task_state_button: Button
@export var line_edit: LineEdit

var current_button_color: int = 0
var button_types: Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text: String


func _ready() -> void:
	task_state_button.theme_type_variation = button_types[current_button_color % 3]
	line_edit.text = text


func _on_task_state_button_pressed() -> void:
	current_button_color += 1
	task_state_button.theme_type_variation = button_types[current_button_color % 3]


func _on_delete_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(new_text: String) -> void:
	text = new_text

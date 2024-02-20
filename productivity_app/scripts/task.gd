class_name Task
extends HBoxContainer


var current_button_color : int = 0
var button_types : Array[StringName] = [&"RedButton", &"YellowButton", &"GreenButton"]
var text : String


func _ready() -> void:
	$TaskStateButton.theme_type_variation = button_types[current_button_color % 3]


func _on_task_state_button_pressed() -> void:
	current_button_color += 1
	$TaskStateButton.theme_type_variation = button_types[current_button_color % 3]


func _on_delete_button_pressed() -> void:
	queue_free()

extends VBoxContainer


@export var project : PackedScene


func _on_new_project_button_pressed() -> void:
	var new_project : VBoxContainer = project.instantiate()
	add_child(new_project)
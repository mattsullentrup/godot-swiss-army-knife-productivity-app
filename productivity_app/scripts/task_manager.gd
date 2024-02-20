extends PanelContainer


@export var task : PackedScene


func _on_new_task_button_pressed() -> void:
	var new_task : HBoxContainer = task.instantiate()
	new_task.task_manager = self
	$TaskVBoxContainer.add_child(new_task)

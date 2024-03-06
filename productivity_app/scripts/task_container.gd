extends VBoxContainer


@export var task : PackedScene


func _on_new_task_button_pressed() -> void:
    var new_task: HBoxContainer = task.instantiate()
    add_child(new_task)

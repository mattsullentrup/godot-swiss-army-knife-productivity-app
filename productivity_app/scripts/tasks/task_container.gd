extends VBoxContainer


@export var task : PackedScene
var are_children_visible := true


func _on_new_task_button_pressed() -> void:
    var new_task: HBoxContainer = task.instantiate()
    add_child(new_task)


func _on_toggle_tasks_button_pressed() -> void:
    var children : Array[Node] = get_children()
    if are_children_visible:
        for child in children:
            child.hide()
        are_children_visible = false

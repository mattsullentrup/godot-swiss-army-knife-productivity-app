extends LineEdit


var is_mouse_hovering: bool = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not is_mouse_hovering:
			release_focus()


func _on_text_submitted(_new_text: String) -> void:
	release_focus()


func _on_mouse_entered() -> void:
	is_mouse_hovering = true


func _on_mouse_exited() -> void:
	is_mouse_hovering = false

extends LineEdit


var is_mouse_hovering: bool = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not is_mouse_hovering:
			release_focus()


func _on_mouse_entered() -> void:
	is_mouse_hovering = true


func _on_mouse_exited() -> void:
	is_mouse_hovering = false


#func _drop_data(at_position: Vector2, data: Variant) -> void:
	#if data is Task:
		#data.get_parent().remove_child(data)
		#get_parent().add_child(data)

extends VBoxContainer


func _on_delete_button_pressed() -> void:
	queue_free()

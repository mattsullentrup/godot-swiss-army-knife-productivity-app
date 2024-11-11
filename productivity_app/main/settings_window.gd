extends Window


func _enter_tree() -> void:
	hide()


func _on_options_button_pressed() -> void:
	show()


func _on_close_requested() -> void:
	hide()

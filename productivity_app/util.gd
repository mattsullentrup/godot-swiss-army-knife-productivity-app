class_name Util



static func setup_child_buttons_focus(node: Node) -> void:
	for child in node.get_children():
		# ToDoItems will call the util function internally.
		# This check exists to prevent task buttons connecting themselves twice
		if child is ProjectManager:
			continue

		var button := child as Button
		if button:
			_connect_focus_signals(button)

		if child.get_child_count():
			setup_child_buttons_focus(child)


static func _connect_focus_signals(button: Button) -> void:
	button.mouse_entered.connect(button.grab_focus)
	button.mouse_exited.connect(func() -> void: if button.has_focus(): button.release_focus())

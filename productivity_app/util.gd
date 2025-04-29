class_name Util


static func connect_focus_signals(button: Button) -> void:
	button.mouse_entered.connect(button.grab_focus)
	button.mouse_exited.connect(func() -> void: if button.has_focus(): button.release_focus())

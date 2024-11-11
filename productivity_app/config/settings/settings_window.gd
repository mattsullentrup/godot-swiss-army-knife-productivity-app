extends Window


@onready var _break_reminder_check_button: CheckButton = %BreakReminderCheckButton


func _ready() -> void:
	hide()
	_break_reminder_check_button.button_pressed = \
			Settings.get_value(Settings.BREAK_REMINDER, Settings.BREAK_REMINDER_DEFAULT)


func _on_options_button_pressed() -> void:
	show()


func _on_close_requested() -> void:
	hide()


func _on_break_reminder_check_button_toggled(toggled_on: bool) -> void:
	Settings.set_value(Settings.BREAK_REMINDER, toggled_on)

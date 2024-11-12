extends Window


@onready var _break_reminder_check_button: CheckButton = %BreakReminderCheckButton
@onready var _reminder_interval_spin_box: SpinBox = %ReminderIntervalSpinBox


func _ready() -> void:
	hide()
	_break_reminder_check_button.button_pressed = Settings.get_value(
			Settings.BREAK_REMINDER, Settings.BREAK_REMINDER_DEFAULT
	)
	_reminder_interval_spin_box.value = Settings.get_value(
			Settings.REMINDER_INTERVAL, Settings.REMINDER_INTERVAL_DEFAULT
	)


func _on_options_button_pressed() -> void:
	show()


func _on_close_requested() -> void:
	hide()


func _on_break_reminder_check_button_toggled(toggled_on: bool) -> void:
	Settings.set_value(Settings.BREAK_REMINDER, toggled_on)


func _on_reminder_interval_spin_box_value_changed(value: float) -> void:
	Settings.set_value(Settings.REMINDER_INTERVAL, value)

extends Window


@onready var _break_reminder_check_button: CheckButton = %BreakReminderCheckButton
@onready var _reminder_interval_spin_box: SpinBox = %ReminderIntervalSpinBox
@onready var _alarm_volume_h_slider: HSlider = %AlarmVolumeHSlider


func _ready() -> void:
	hide()
	_break_reminder_check_button.button_pressed = Settings.get_value(
			Settings.BREAK_REMINDER, Settings.BREAK_REMINDER_DEFAULT)
	_reminder_interval_spin_box.value = Settings.get_value(
			Settings.REMINDER_INTERVAL, Settings.REMINDER_INTERVAL_DEFAULT)
	var vol: float = Settings.get_value(Settings.ALARM_VOLUME, Settings.ALARM_VOLUME_DEFAULT)
	if vol is float:
		_alarm_volume_h_slider.value = db_to_linear(vol)


func _on_options_button_pressed() -> void:
	show()


func _on_close_requested() -> void:
	hide()
	Settings.save_settings()


func _on_break_reminder_check_button_toggled(toggled_on: bool) -> void:
	Settings.set_value(Settings.BREAK_REMINDER, toggled_on)


func _on_reminder_interval_spin_box_value_changed(value: float) -> void:
	Settings.set_value(Settings.REMINDER_INTERVAL, value)


func _on_alarm_volume_h_slider_value_changed(value: float) -> void:
	Settings.set_value(Settings.ALARM_VOLUME, linear_to_db(value))

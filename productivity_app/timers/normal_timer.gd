extends PanelContainer


const STOP = preload("res://addons/images/kenney_icons/stop.png")
const START = preload("res://addons/images/kenney_icons/right.png")

var _normal_length: float
var _overtime_start_time: float
var _is_in_overtime := false

@onready var _notification_sound: AudioStreamPlayer = %NotificationSound
@onready var _reminder_timer: Timer = $ReminderTimer
@onready var _time_remaining_label: Label = %TimeRemainingLabel
@onready var _timer: Timer = $NormalTimer
@onready var _spin_box: SpinBox = %TimerSpinBox
@onready var _toggle_button: Button = %TimerToggleButton


func _ready() -> void:
	_normal_length = _spin_box.value# * 60
	_time_remaining_label.text = str(_normal_length)
	_reminder_timer.timeout.connect(func() -> void: _notification_sound.play())


func _process(_delta: float) -> void:
	_time_remaining_label.text = TimerUtilities.get_formatted_time_from_seconds(
			_get_time_to_display())


func _get_time_to_display() -> float:
	if not _timer.is_stopped():
		return _timer.time_left
	elif _is_in_overtime:
		return TimerUtilities.get_overtime(_overtime_start_time)
	return _normal_length


func _on_timer_timeout() -> void:
	_notification_sound.play()
	_overtime_start_time = Time.get_unix_time_from_system()
	_is_in_overtime = true
	if Settings.get_value(Settings.BREAK_REMINDER, Settings.BREAK_REMINDER_DEFAULT) == true:
		var length: float = Settings.get_value(
				Settings.REMINDER_INTERVAL, Settings.REMINDER_INTERVAL_DEFAULT)
		_reminder_timer.start(length)# * 60)


func _on_timer_option_button_value_changed(value: float) -> void:
	_normal_length = value * 60
	_is_in_overtime = false


func _on_add_minute_button_pressed() -> void:
	if not _timer.is_stopped():
		var time_left := _timer.time_left
		_timer.stop()
		_timer.start(time_left + 60)


func _on_timer_toggle_button_pressed() -> void:
	var set_toggle_button: Callable = func(icon: Texture2D, color_type: String) -> void:
		_toggle_button.icon = icon
		_toggle_button.theme_type_variation = color_type

	if _timer.time_left:
		_timer.stop()
		set_toggle_button.call(START, "GreenButton")
	elif _is_in_overtime:
		_is_in_overtime = false
		if _reminder_timer.time_left:
			_reminder_timer.stop()
		set_toggle_button.call(START, "GreenButton")
	else:
		_timer.start(_normal_length)
		set_toggle_button.call(STOP, "RedButton")

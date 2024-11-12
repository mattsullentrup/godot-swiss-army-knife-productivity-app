extends PanelContainer


@export var timer: Timer
@export var time_remaining_label: Label

@onready var option_button: OptionButton = %TimerOptionButton

var _normal_length: float
var overtime_start_time: float
var is_in_overtime := false

@onready var notification_sound: AudioStreamPlayer = %NotificationSound
@onready var _reminder_timer: Timer = $ReminderTimer


func _ready() -> void:
	option_button.selected = 0
	for i in range(1, 13):
		option_button.add_item(str(i * 5), i * 5)

	_normal_length = option_button.get_selected_id() * 60
	time_remaining_label.text = str(_normal_length)
	_reminder_timer.timeout.connect(func() -> void: notification_sound.play())


func _process(_delta: float) -> void:
	if not timer.is_stopped():
		time_remaining_label.text = TimerUtilities.get_formatted_time_from_seconds(timer.time_left)
	elif is_in_overtime:
		time_remaining_label.text = TimerUtilities.get_formatted_time_from_seconds(
				TimerUtilities.get_overtime(overtime_start_time)
		)
	else:
		time_remaining_label.text = TimerUtilities.get_formatted_time_from_seconds(_normal_length)


func _on_timer_start_button_pressed() -> void:
	timer.stop()
	timer.start(_normal_length)
	#timer.start(0.1)
	is_in_overtime = false


func _on_timer_stop_button_pressed() -> void:
	timer.stop()
	is_in_overtime = false
	#if _reminder_timer:
	_reminder_timer.stop()


func _on_timer_timeout() -> void:
	notification_sound.play()
	overtime_start_time = Time.get_unix_time_from_system()
	is_in_overtime = true
	if Settings.get_value(Settings.BREAK_REMINDER, Settings.BREAK_REMINDER_DEFAULT) == true:
		var length: float = Settings.get_value(
				Settings.REMINDER_INTERVAL, Settings.REMINDER_INTERVAL_DEFAULT
		)
		_reminder_timer.start(length * 60)


func _on_timer_option_button_item_selected(index: int) -> void:
	_normal_length = option_button.get_item_id(index) * 60
	is_in_overtime = false

extends TabBar


enum Round {
	FIRST = 1,
	SECOND = 2,
	THIRD = 3,
	FOURTH = 4,
}

@export var pomodoro_timer : Timer
@export var round_label : Label
@export var pomodoro_time_remaining_label : Label
@export var pomodoro_timer_message : Label
@export var short_break_length : int = 2
@export var long_break_length : int = 3
@export var work_round_length : int = 1

var is_on_break : bool
var is_in_overtime : bool
var is_paused : bool = false
var timer_length : int
var time_to_display : float
var timeout_mark : float

@onready var current_round : int = 1
@onready var start_button : Button = %PomodoroStartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound


func _ready() -> void:
	short_break_length *= 60
	long_break_length *= 60
	work_round_length *= 60

	timer_length = work_round_length

	change_round()


func _process(_delta: float) -> void:
	if is_in_overtime:
		time_to_display = timeout_mark - Time.get_unix_time_from_system()
	else:
		time_to_display = pomodoro_timer.time_left

	pomodoro_time_remaining_label.text = get_formatted_time_from_seconds(ceili(time_to_display))


func change_round() -> void:
	timer_length = work_round_length
	round_label.text = str(current_round) + '/4'
	pomodoro_timer_message.hide()
	is_on_break = false


func get_formatted_time_from_seconds(seconds : int) -> String:
	var is_negative : bool = false
	if seconds < 0:
		seconds = abs(seconds)
		is_negative = true


	var hours : int = seconds / 3600
	seconds -= hours * 3600

	var minutes : int = seconds / 60
	seconds -= minutes * 60


	if is_negative:
		return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)
	else:
		return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)


func _on_pomodoro_timer_start_button_pressed() -> void:
	if is_paused:
		pomodoro_timer.paused = false
		is_paused = false
		return
	pomodoro_timer.stop()
	pomodoro_timer.start(timer_length)
	pomodoro_timer_message.hide()
	is_in_overtime = false


func _on_pomodoro_timer_stop_button_pressed() -> void:
	pomodoro_timer.stop()


func _on_pomodoro_timer_timeout() -> void:
	if is_on_break:
		if current_round == 4:
			current_round = 1
		else:
			current_round += 1;
		start_button.text = "Start"
		change_round()
		pomodoro_timer_message.text = "Get back to it"
	else:
		is_on_break = true
		start_button.text = "Break"
		if current_round == 4:
			timer_length = long_break_length
			pomodoro_timer_message.text = "Long break"
		else:
			timer_length = short_break_length
			pomodoro_timer_message.text = "Short break"

	pomodoro_timer_message.show()

	timeout_mark = Time.get_unix_time_from_system()
	is_in_overtime = true
	notification_sound.play()


func _on_reset_button_pressed() -> void:
	current_round = 1
	pomodoro_timer.stop()
	change_round()


func _on_pomodoro_pause_button_pressed() -> void:
	if is_paused:
		pomodoro_timer.paused = false
		is_paused = false
		return

	pomodoro_timer.paused = true
	is_paused = true

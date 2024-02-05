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

var is_on_break : bool
var is_in_overtime : bool
var timer_length : int
var time_to_display : float
var timeout_mark : float

@onready var short_break_length : int = 2
@onready var long_break_length : int = 3
@onready var work_round_length : int = 5
@onready var current_round : int = 1
@onready var start_button: Button = %PomodoroStartButton


func _ready() -> void:
	timer_length = work_round_length
	change_round()


func _process(_delta: float) -> void:
	#pomodoro_time_remaining_label.text = type_convert(ceilf(pomodoro_timer.time_left), TYPE_STRING)
	#pomodoro_time_remaining_label.text = get_formatted_time_from_seconds(pomodoro_timer.time_left)
	#print(Time.get_unix_time_from_system())
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


func get_formatted_time_from_seconds(_secs : int) -> String:
	var neg : bool = false
	if _secs < 0:
		_secs = abs(_secs)
		neg = true
	var hours : int = _secs / 3600
	_secs -= hours * 3600
	var minutes : int = _secs / 60
	_secs -= minutes * 60

	if neg:
		return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % _secs)
	else:
		return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % _secs)


func _on_pomodoro_timer_start_button_pressed() -> void:
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



func _on_reset_button_pressed() -> void:
	current_round = 1
	pomodoro_timer.stop()
	change_round()

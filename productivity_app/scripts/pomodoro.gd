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
var timer_length : int

@onready var short_break_length : int = 2
@onready var long_break_length : int = 3
@onready var work_round_length : int = 5
@onready var current_round : int = 1
@onready var start_button: Button = %PomodoroStartButton


func _ready() -> void:
	timer_length = work_round_length
	change_round()


func change_round() -> void:
	timer_length = work_round_length
	round_label.text = str(current_round) + '/4'
	pomodoro_timer_message.hide()
	is_on_break = false


func _process(_delta: float) -> void:
	pomodoro_time_remaining_label.text = type_convert(ceilf(pomodoro_timer.time_left), TYPE_STRING)


func _on_pomodoro_timer_start_button_pressed() -> void:
	pomodoro_timer.stop()
	pomodoro_timer.start(timer_length)
	pomodoro_timer_message.hide()


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


func _on_reset_button_pressed() -> void:
	current_round = 1
	pomodoro_timer.stop()
	change_round()

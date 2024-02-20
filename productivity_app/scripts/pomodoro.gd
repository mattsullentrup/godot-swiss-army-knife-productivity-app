class_name Pomodoro
extends TabBar


enum Round { ZERO, FIRST, SECOND, THIRD, FOURTH }
enum State {
	IDLE,
	PAUSED,
	WORK,
	BREAK,
	OVERTIME,
}

@export var initial_state : State
@export var pomodoro_timer : Timer

@export_group("Labels")
@export var round_label : Label
@export var timer_message : Label
@export var paused_message : Label

static var _time_to_display : float
static var time_to_display : float:
	get:
		return _time_to_display

var current_state : State = State.IDLE
var productivity_state : State = State.WORK
var overtime_start_time : float
var overtime_count : float
var timer_length : float

@onready var short_break_length : float = 5 * 60
@onready var long_break_length : float = 15 * 60
@onready var work_round_length : float = 25 * 60
@onready var current_round : int = 1
@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar := %ProgressBar


func _ready() -> void:
	progress_bar.value = progress_bar.max_value
	timer_length = work_round_length
	_time_to_display = timer_length
	print_state_conditions()


func _process(_delta: float) -> void:
	if not pomodoro_timer.is_stopped():
		progress_bar.value = pomodoro_timer.time_left
		_time_to_display = pomodoro_timer.time_left
	elif current_state == State.OVERTIME:
		_time_to_display = overtime_start_time - Time.get_unix_time_from_system()


func change_state(new_state : State) -> void:
	timer_message.show()
	paused_message.hide()

	match new_state:
		State.WORK:
			pomodoro_timer.paused = false
			if current_state == State.PAUSED:
				paused_message.hide()
			else:
				if current_state != State.IDLE:
					current_round += 1
				check_current_round()
				timer_length = work_round_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Work"
				productivity_state = State.WORK
		State.BREAK:
			pomodoro_timer.paused = false
			if current_state == State.PAUSED:
				paused_message.hide()
			else:
				if current_round == Round.FOURTH:
					timer_length = long_break_length
				else:
					timer_length = short_break_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Break"
				productivity_state = State.BREAK
		State.PAUSED:
			pomodoro_timer.paused = true
			paused_message.show()
		State.OVERTIME:
			overtime_start_time = Time.get_unix_time_from_system()
			notification_sound.play()
			progress_bar.value = 0
		State.IDLE:
			pomodoro_timer.stop()
			timer_message.hide()
			progress_bar.value = progress_bar.max_value
			#_time_to_display = timer_length


	current_state = new_state

	print_state_conditions()


func print_state_conditions() -> void:
	print("-------------------")
	print("current round: ", Round.find_key(current_round))
	print("current state: ", State.find_key(current_state))
	print("prod state: ", State.find_key(productivity_state))
	print("-------------------")


func check_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	round_label.text = str(current_round) + '/4'


func determine_break_length() -> void:
	if current_round == Round.FOURTH:
		_time_to_display = long_break_length
	else:
		_time_to_display = short_break_length


func _on_pomodoro_timer_timeout() -> void:
	change_state(State.OVERTIME)


func _on_start_button_pressed() -> void:
	match current_state:
		State.OVERTIME:
			if productivity_state == State.BREAK:
				change_state(State.WORK)
			else:
				change_state(State.BREAK)
		State.IDLE:
			change_state(productivity_state)
		_:
			print("start button unavailable")


func _on_go_back_button_pressed() -> void:
	if current_state == State.IDLE:
		if productivity_state == State.BREAK:
			productivity_state = State.WORK
			_time_to_display = work_round_length
		else:
			productivity_state = State.BREAK
			current_round -= 1
			check_current_round()
			determine_break_length()
	else:
		change_state(State.IDLE)
		if productivity_state == State.BREAK:
			determine_break_length()
		else:
			_time_to_display = work_round_length

	check_current_round()
	print_state_conditions()


func _on_pause_button_pressed() -> void:
	match current_state:
		State.IDLE, State.OVERTIME:
			print("pause unavailable")
		State.PAUSED:
			change_state(productivity_state)
		_:
			change_state(State.PAUSED)


func _on_skip_button_pressed() -> void:
	match current_state:
		State.IDLE:
			if productivity_state == State.BREAK:
				productivity_state = State.WORK
				_time_to_display = work_round_length
				current_round += 1
			else:
				productivity_state = State.BREAK
				determine_break_length()
		State.BREAK:
			current_round += 1
			productivity_state = State.WORK
			_time_to_display = work_round_length
		State.WORK:
			productivity_state = State.BREAK
			determine_break_length()
		State.OVERTIME:
			if productivity_state == State.BREAK:
				productivity_state = State.WORK
				_time_to_display = work_round_length
				current_round += 1
			else:
				productivity_state = State.BREAK
				determine_break_length()
	change_state(State.IDLE)

	check_current_round()
	print_state_conditions()


func _on_stop_button_pressed() -> void:
	productivity_state = State.WORK
	current_round = Round.FIRST
	check_current_round()
	_time_to_display = work_round_length
	change_state(State.IDLE)


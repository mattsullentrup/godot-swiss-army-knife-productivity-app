class_name Pomodoro
extends TabBar


enum Round { FIRST = 1, SECOND = 2, THIRD = 3, FOURTH = 4 }
enum State {
	IDLE,
	PAUSED,
	WORK,
	BREAK,
	OVERTIME,
}

@export var initial_state : State

@export_group("References")
@export var pomodoro_timer : Timer

@export_subgroup("Labels")
@export var round_label : Label
@export var timer_message : Label
@export var paused_message : Label

@export_group("Timer Lengths")
@export var short_break_length : float = 7
@export var long_break_length : float = 1
@export var work_round_length : float = 5

# set this to work to avoid confusion when first starting application
# specifically when pressing play when the current state is IDLE
#static var previous_state := State.WORK

static var _time_to_display : float
static var time_to_display : float:
	get:
		return _time_to_display


var current_state : State = State.IDLE
var productivity_state : State = State.WORK
var overtime_start_time : float
var overtime_count : float
var timer_length : float
var current_round : Round


@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar


func _ready() -> void:
	progress_bar.value = progress_bar.max_value
	timer_length = work_round_length
	_time_to_display = timer_length


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
				#current_round += 1
				#round_label.text = str(current_round) + '/4'
				timer_length = work_round_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Work"
				#pomodoro_timer.paused = false
				productivity_state = State.WORK
		State.BREAK:
			pomodoro_timer.paused = false
			if current_state == State.PAUSED:
				paused_message.hide()
			else:
				timer_length = short_break_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Break"
				#pomodoro_timer.paused = false
				productivity_state = State.BREAK
		State.PAUSED:
			#if pomodoro_timer.paused == false:
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
			_time_to_display = timer_length


	current_state = new_state

	print_state_conditions()


func print_state_conditions() -> void:
	for item : String in State:
		if State.find_key(current_state):
			print("current: ", State.find_key(current_state))

	for item : String in State:
		if State.find_key(productivity_state):
			print("prod state: ", State.find_key(productivity_state))


func _on_pomodoro_timer_timeout() -> void:
	change_state(State.OVERTIME)


func _on_start_button_pressed() -> void:
	match current_state:
		State.OVERTIME:
			if productivity_state == State.BREAK:
				change_state(State.WORK)
			elif productivity_state == State.WORK:
				change_state(State.BREAK)
		State.IDLE:
			change_state(productivity_state)
		_:
			print("start button unavailable")


func _on_go_back_button_pressed() -> void:
	match current_state:
		State.IDLE:
			print("go back unavailable")
		_:
			change_state(State.IDLE)


func _on_pause_button_pressed() -> void:
	match current_state:
		State.IDLE, State.OVERTIME:
			print("pause unavailable")
		State.PAUSED:
			change_state(productivity_state)
		_:
			change_state(State.PAUSED)


func _on_skip_button_pressed() -> void:
	change_state(State.IDLE)
	current_round += 1


func _on_stop_button_pressed() -> void:
	productivity_state = State.WORK
	current_round = Round.FIRST
	timer_length = work_round_length
	change_state(State.IDLE)

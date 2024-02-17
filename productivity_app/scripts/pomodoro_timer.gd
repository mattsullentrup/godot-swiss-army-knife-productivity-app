class_name Pomodoro
extends TabBar


enum Round { FIRST, SECOND, THIRD, FOURTH }

@export var initial_state : PomodoroStates.State

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

static var previous_state : PomodoroStates.State
static var _time_to_display : float
static var time_to_display : float:
	get:
		return _time_to_display
static var _current_state : PomodoroStates.State
static var current_state : PomodoroStates.State:
	get:
		return _current_state

var overtime_start_time : float
var overtime_count : float
var timer_length : float
var current_round : Round


@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
@onready var button_manager: HBoxContainer = %ButtonManager


func _ready() -> void:
	_current_state = initial_state

	button_manager.valid_button_pressed.connect(change_state)


func _process(_delta: float) -> void:
	#if previous_state == null:
		#return

	#match _current_state:
		#PomodoroStates.State.IDLE when previous_state == PomodoroStates.State.WORK or previous_state == PomodoroStates.State.BREAK:
			#_time_to_display = timer_length

	if not pomodoro_timer.is_stopped():
		progress_bar.max_value = timer_length
		progress_bar.value = pomodoro_timer.time_left
		_time_to_display = pomodoro_timer.time_left
	else:
		_time_to_display = overtime_start_time - Time.get_unix_time_from_system()


func change_state(state : PomodoroStates.State) -> void:
	match state:
		PomodoroStates.State.WORK:
			timer_length = work_round_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Work"
			timer_message.show()
		PomodoroStates.State.BREAK:
			timer_length = short_break_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Break"
		PomodoroStates.State.IDLE when _current_state == PomodoroStates.State.WORK:
			timer_message.text = "Take a break"
			timer_message.show()
		PomodoroStates.State.IDLE when _current_state == PomodoroStates.State.BREAK:
			timer_message.text = "Get back to it"
			timer_message.show()

	previous_state = _current_state
	_current_state = state


func _on_button_manager_valid_button_pressed(state : PomodoroStates.State) -> void:
	change_state(state)


func _on_pomodoro_timer_timeout() -> void:
	change_state(PomodoroStates.State.IDLE)
	overtime_start_time = Time.get_unix_time_from_system()
	notification_sound.play()

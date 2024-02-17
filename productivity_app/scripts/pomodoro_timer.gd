class_name Pomodoro
extends TabBar


enum Round { FIRST, SECOND, THIRD, FOURTH }

@export var initial_state : PomodoroStates.State

@export_group("References")
@export var pomodoro_timer : Timer

@export_subgroup("Labels")
@export var round_label : Label
@export var time_remaining_label : Label
@export var timer_message : Label
@export var paused_message : Label

@export_group("Timer Lengths")
@export var short_break_length : float = 7
@export var long_break_length : float = 1
@export var work_round_length : float = 5

var timer_length : float
var time_to_display : float
var overtime_start_time : float
var current_round : Round

static var previous_state : PomodoroStates.State
static var current_state : PomodoroStates.State

@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
@onready var button_manager: HBoxContainer = %ButtonManager


func _ready() -> void:
	current_state = initial_state
	time_remaining_label.timer = pomodoro_timer

	button_manager.valid_button_pressed.connect(change_state)


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
		PomodoroStates.State.IDLE when current_state == PomodoroStates.State.WORK:
			timer_message.text = "Take a break"
			timer_message.show()
		PomodoroStates.State.IDLE when current_state == PomodoroStates.State.BREAK:
			timer_message.text = "Get back to it"
			timer_message.show()

	previous_state = current_state
	current_state = state


func _on_button_manager_valid_button_pressed(state : PomodoroStates.State) -> void:
	change_state(state)


func _on_pomodoro_timer_timeout() -> void:
	change_state(PomodoroStates.State.IDLE)

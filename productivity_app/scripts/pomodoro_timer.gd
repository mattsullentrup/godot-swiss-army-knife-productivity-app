extends TabBar


enum Round { FIRST, SECOND, THIRD, FOURTH }

@export var current_state : PomodoroStates.State

@export_group("References")
@export var pomodoro_timer : Timer

@export_subgroup("Labels")
@export var round_label : Label
@export var time_remaining_label : Label
@export var timer_message : Label
@export var paused_message : Label

@export_group("Timer Lengths")
@export var short_break_length : float = .07
@export var long_break_length : float = .1
@export var work_round_length : float = .05

var timer_length : int
var time_to_display : float
var overtime_start_time : float
var previous_state : PomodoroStates.State
var current_round : Round

@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
@onready var button_manager: HBoxContainer = %ButtonManager


func _ready() -> void:
	time_remaining_label.timer = pomodoro_timer

	button_manager.current_state = current_state
	button_manager.valid_button_pressed.connect(change_state)


func change_state(state : PomodoroStates.State) -> void:
	previous_state = state


func _on_button_manager_valid_button_pressed(state : PomodoroStates.State) -> void:
	change_state(state)

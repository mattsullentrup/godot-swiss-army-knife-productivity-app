class_name PomodoroStateMachine
extends Node


signal round_changed(new_round: int)
signal state_changed(progress_bar_max_value: float)

const MINUTE_MULTIPLIER = 60
const MAX_ROUND = 4

const Idle = preload("res://timers/pomodoro_state_machine/states/idle.gd")
const Work = preload("res://timers/pomodoro_state_machine/states/work.gd")
const Break = preload("res://timers/pomodoro_state_machine/states/break.gd")
const Paused = preload("res://timers/pomodoro_state_machine/states/paused.gd")
const Overtime = preload("res://timers/pomodoro_state_machine/states/overtime.gd")

var initial_state: State

@onready var buttons := {
	"start": %StartButton,
	"go_back": %GoBackButton,
	"pause": %PauseButton,
	"skip": %SkipButton,
	"stop": %StopButton
}

var current_state: State = null
var previous_state: State = null
var states := {}
var notification_sound: AudioStreamPlayer = null

var short_break_length: float = 5 * MINUTE_MULTIPLIER
var long_break_length: float = 15 * MINUTE_MULTIPLIER
var work_round_length: float = 25 * MINUTE_MULTIPLIER

var time_to_display: float
var timer_length: float

var current_round: int:
	set(value):
		current_round = value
		current_round = wrap(current_round, 1, MAX_ROUND + 1)
		round_changed.emit(current_round)

@onready var pomodoro_timer: Timer = %PomodoroTimer

@onready var idle_state: IdleState = $Idle
@onready var work_state: WorkState = $Work
@onready var break_state: BreakState = $Break
@onready var overtime_state: OvertimeState = $Overtime
@onready var paused_state: PausedState = $Paused

@onready var states_list: Array[State] = [
	idle_state,
	work_state,
	break_state,
	overtime_state,
	paused_state
]


func _ready() -> void:
	current_round = 1
	_connect_buttons()
	_setup_states()
	#var overtime: Variant = states.overtime
	#if overtime is State:
	pomodoro_timer.timeout.connect(_change_state.bind(overtime_state))


func _process(_delta: float) -> void:
	current_state._update()


func _connect_buttons() -> void:
	for button: Button in buttons.values():
		button.pressed.connect(_on_button_pressed.bind(button))


func _setup_states() -> void:
	for state: State in states_list:
		states[state.name.to_lower()] = state
		state.finished.connect(_change_state)
		state.state_machine = self
		state.buttons = buttons
		state.states = states

	if initial_state == null:
		initial_state = idle_state

	_change_state(initial_state)


func _change_state(new_state: State) -> void:
	if new_state is not State:
		return

	state_changed.emit(time_to_display)
	if current_state:
		current_state._exit()

	previous_state = current_state
	current_state = new_state
	current_state._enter()


func _on_button_pressed(button: Button) -> void:
	current_state._on_button_pressed(button)

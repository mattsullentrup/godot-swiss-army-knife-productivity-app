class_name PomodoroStateMachine
extends Node


signal round_changed(new_round: int)
signal state_changed(
		new_state_name: String,
		is_break_state: bool,
		progress_bar_max_value: float
)

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
var states_array := []
var notification_sound: AudioStreamPlayer = null

var short_break_length: float = 5 * MINUTE_MULTIPLIER
var long_break_length: float = 15 * MINUTE_MULTIPLIER
#var work_round_length: float = 25 * MINUTE_MULTIPLIER
var work_round_length: float = 1

var time_to_display: float
var timer_length: float

var current_round: int:
	set(value):
		current_round = value
		current_round = wrap(current_round, 1, MAX_ROUND + 1)
		round_changed.emit(current_round)

@onready var pomodoro_timer: Timer = %PomodoroTimer


func _ready() -> void:
	current_round = 1
	_connect_buttons()
	_setup_states()
	var overtime: Variant = states.overtime
	assert(overtime is OvertimeState)
	if overtime is State:
		pomodoro_timer.timeout.connect(_change_state.bind(overtime))


func _process(_delta: float) -> void:
	current_state._update()


func _connect_buttons() -> void:
	for button: Button in buttons.values():
		button.pressed.connect(_on_button_pressed.bind(button))


func _setup_states() -> void:
	var idle_state := Idle.new(self, states, buttons)
	var work_state := Work.new(self, states, buttons)
	var break_state := Break.new(self, states, buttons)
	var paused_state := Paused.new(self, states, buttons)
	var overtime_state := Overtime.new(self, states, buttons, %ReminderTimer as Timer)

	states["idle"] = idle_state
	states["work"] = work_state
	states["break"] = break_state
	states["paused"] = paused_state
	states["overtime"] = overtime_state

	if initial_state == null:
		initial_state = idle_state

	for state: State in states.values():
		state.finished.connect(_change_state)
		states_array.append(state)

	_change_state(initial_state)


func _change_state(new_state: State) -> void:
	if new_state is not State:
		return

	state_changed.emit(new_state, new_state.is_break_state, time_to_display)
	if current_state:
		current_state._exit()

	previous_state = current_state
	current_state = new_state
	current_state._enter()


func _on_button_pressed(button: Button) -> void:
	current_state._on_button_pressed(button)


#func _on_pomodoro_timer_timeout() -> void:
	#_change_state(states.overtime as OvertimeState)

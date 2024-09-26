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

@export var initial_state: Node

var buttons: Array[Button]
var current_state: State = null
var previous_state: State = null
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


func _ready() -> void:
	current_round = 1
	_connect_buttons()
	_setup_states()


func _process(_delta: float) -> void:
	current_state._update()


func _connect_buttons() -> void:
	for button: Button in %Buttons.get_children():
		buttons.append(button)
		button.pressed.connect(_on_button_pressed.bind(button))


func _setup_states() -> void:
	if initial_state == null:
		initial_state = get_child(0)

	var states: Array = get_children().filter(func(x: Node) -> bool: return x is State)
	for state: State in states:
		state.finished.connect(_change_state)
		state._initialize(self, states, buttons)

	_change_state(initial_state)


func _change_state(new_state: Node) -> void:
	if new_state is not State:
		return

	state_changed.emit(new_state, new_state.is_break_state, time_to_display)
	if current_state:
		current_state._exit()

	previous_state = current_state
	current_state = new_state
	current_state._enter(previous_state)


func _on_button_pressed(button: Button) -> void:
	current_state._on_button_pressed(button)

class_name PomodoroStateMachine
extends Node


enum Round {
	ZERO,
	FIRST,
	SECOND,
	THIRD,
	FOURTH,
}

enum ProductivityState {
	BREAK,
	WORK,
}

const MINUTE_MULTIPLIER = 60

@export var initial_state: Node

static var time_to_display: float

var states: Dictionary = {}
var current_state: PomodoroState = null
var previous_state: PomodoroState = null
var notification_sound: AudioStreamPlayer = null
var productivity_state: int
var timer_length: float

@onready var pomodoro_timer: Timer = %PomodoroTimer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var short_break_length: float = 5
@onready var long_break_length: float = 15
@onready var work_round_length: float = 25
@onready var current_round: int


func _ready() -> void:
	_setup_states()

	short_break_length *= MINUTE_MULTIPLIER
	long_break_length *= MINUTE_MULTIPLIER
	work_round_length *= MINUTE_MULTIPLIER


func _process(_delta: float) -> void:
	current_state._update()


func _setup_states() -> void:
	if initial_state == null:
		initial_state = get_child(0)

	for child in get_children():
		if child is PomodoroState:
			var state: PomodoroState = child
			states[state.name.to_lower()] = state
			initialize(state)
			continue

		push_error("Child" + child.name + " is not a State")

	change_state(initial_state.name)


func initialize(state: PomodoroState) -> void:
	state.state_machine = self


func change_state(new_state_name: String) -> void:
	var new_state: PomodoroState = states.get(new_state_name.to_lower())
	if not new_state or current_state == new_state:
		return

	if current_state:
		current_state._exit()

	previous_state = current_state
	current_state = new_state
	current_state._enter(previous_state)


func _get_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	#round_label.text = str(current_round) + '/4'


func _on_start_button_pressed() -> void:
	#change_state("Work")

	match current_state:
		states["Overtime"]:
			if productivity_state == ProductivityState.BREAK:
				change_state("Work")
			else:
				change_state("Work")
		states["Idle"]:
			change_state(ProductivityState.get(productivity_state))
		_:
			print("start button unavailable")


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	change_state("Idle")


func _on_pomodoro_timer_timeout() -> void:
	change_state("Overtime")

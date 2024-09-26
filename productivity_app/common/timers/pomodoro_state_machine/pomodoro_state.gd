class_name State
extends Node


@warning_ignore("unused_signal")
signal finished(next_state: State)

static var is_break_state := false

# References
var state_machine: PomodoroStateMachine
var idle_state: IdleState
var work_state: WorkState
var break_state: BreakState
var paused_state: PausedState
var overtime_state: OvertimeState

var _start_button: Button
var _go_back_button: Button
var _pause_button: Button
var _skip_button: Button
var _stop_button: Button


func _initialize(
			p_state_machine: PomodoroStateMachine = null,
			p_states: Array = [],
			p_buttons: Array = []
) -> void:
	state_machine = p_state_machine
	if p_states == null:
		push_error("states array is null")
		return

	idle_state = p_states[0]
	work_state = p_states[1]
	break_state = p_states[2]
	paused_state = p_states[3]
	overtime_state = p_states[4]

	_start_button = p_buttons[0]
	_go_back_button = p_buttons[1]
	_pause_button = p_buttons[2]
	_skip_button = p_buttons[3]
	_stop_button = p_buttons[4]


func _print_state_info(transition_status: String) -> void:
	printt(
			transition_status + ' ' + self.name + ' | ' \
			+ "is_break_state: " + str(is_break_state) + ' | ' \
			+ "round: " + str(state_machine.current_round) + ' | ' \
			+ "timer: " + str(state_machine.pomodoro_timer.time_left)
	)

func _enter(_previous_state: State) -> void:
	_print_state_info("Entering")


func _update() -> void:
	pass


func _exit() -> void:
	_print_state_info("Exiting")
	print("~~~~~~~~")


func _on_button_pressed(_button: Button) -> void:
	pass

class_name State
extends Node


@warning_ignore("unused_signal")
signal finished(next_state: State)

enum ButtonType {
	START,
	GO_BACK,
	PAUSE,
	SKIP,
	STOP,
}

var state_machine: PomodoroStateMachine
var idle_state: IdleState
var work_state: WorkState
var break_state: BreakState
var paused_state: PausedState
var overtime_state: OvertimeState


func _init(
		p_state_machine: PomodoroStateMachine = null,
		p_idle_state: IdleState = null,
		p_work_state: WorkState = null,
		p_break_state: BreakState = null,
		p_paused_state: PausedState = null,
		p_overtime_state: OvertimeState = null
) -> void:
	state_machine = p_state_machine
	idle_state = p_idle_state
	work_state = p_work_state
	break_state = p_break_state
	paused_state = p_paused_state
	overtime_state = p_overtime_state


func _print_state_info(transition_status: String) -> void:
	printt(
			transition_status + ' ' + self.name + ' | ' \
			+ "is_break_state: " + str(state_machine.is_break_state) + ' | ' \
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


func _on_button_pressed(_button: ButtonType) -> void:
	pass

class_name State
extends Node


@warning_ignore("unused_signal")
signal finished(next_state: String)

enum ButtonType {
	START,
	GO_BACK,
	PAUSE,
	SKIP,
	STOP,
}

enum ProductivityState {
	BREAK,
	WORK,
}

var state_machine: PomodoroStateMachine

@onready var state_name: StringName:
	get:
		return self.name.to_lower()


func _print_state_info(transition_status: String) -> void:
	printt(
			transition_status + ' ' + self.name + ' | ' \
			+ ProductivityState.find_key(state_machine.productivity_state) + ' | ' \
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

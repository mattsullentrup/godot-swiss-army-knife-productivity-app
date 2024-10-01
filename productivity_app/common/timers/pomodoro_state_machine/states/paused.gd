class_name PausedState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	state_machine.pomodoro_timer.paused = true


func _exit() -> void:
	super()
	state_machine.pomodoro_timer.paused = false


func _on_button_pressed(button: Button) -> void:
	match button:
		_pause_button, _start_button:
			if is_break_state:
				finished.emit(break_state)
			else:
				finished.emit(work_state)
		_stop_button:
			is_break_state = false
			state_machine.current_round = 1
			finished.emit(idle_state)
		_skip_button:
			if is_break_state:
				is_break_state = false
				state_machine.current_round += 1
			else:
				is_break_state = true

			finished.emit(idle_state)
		_go_back_button:
			finished.emit(idle_state)

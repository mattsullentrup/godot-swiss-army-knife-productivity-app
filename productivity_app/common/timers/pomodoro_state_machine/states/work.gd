class_name WorkState
extends State


func _enter(previous_state: State) -> void:
	match previous_state:
		idle_state, overtime_state:
			state_machine.pomodoro_timer.start(state_machine.work_round_length)
		paused_state:
			state_machine.pomodoro_timer.paused = false
		work_state, break_state:
			state_machine.pomodoro_timer.stop()
		_:
			print("No previous state")

	is_break_state = false

	super(previous_state)


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _on_button_pressed(button: Button) -> void:
	match button:
		_stop_button:
			state_machine.current_round = 1
			finished.emit(idle_state)
		_pause_button:
			finished.emit(paused_state)
		_skip_button:
			is_break_state = true
			finished.emit(idle_state)
		_go_back_button:
			is_break_state = false
			finished.emit(idle_state)

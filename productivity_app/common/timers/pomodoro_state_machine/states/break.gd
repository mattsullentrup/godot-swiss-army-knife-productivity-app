class_name BreakState
extends State


func _enter(previous_state: State) -> void:
	match previous_state:
		idle_state, overtime_state:
			if state_machine.current_round == state_machine.MAX_ROUND:
				state_machine.pomodoro_timer.start(state_machine.long_break_length)
			else:
				state_machine.pomodoro_timer.start(state_machine.short_break_length)
		paused_state:
			state_machine.pomodoro_timer.paused = false
		work_state, break_state:
			state_machine.pomodoro_timer.stop()
		_:
			print("No previous state")

	state_machine.is_break_state = true

	super(previous_state)


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.STOP:
			state_machine.is_break_state = false
			finished.emit(idle_state)
		ButtonType.PAUSE:
			finished.emit(paused_state)
		ButtonType.SKIP:
			state_machine.is_break_state = false
			state_machine.current_round += 1
			finished.emit(idle_state)
		ButtonType.GO_BACK:
			state_machine.is_break_state = true
			finished.emit(idle_state)

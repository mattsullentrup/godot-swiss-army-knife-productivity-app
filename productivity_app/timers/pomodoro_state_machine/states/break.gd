class_name BreakState
extends State


func _enter() -> void:
	match state_machine.previous_state:
		states.idle, states.overtime:
			if state_machine.current_round == state_machine.MAX_ROUND:
				state_machine.pomodoro_timer.start(state_machine.long_break_length)
			else:
				state_machine.pomodoro_timer.start(state_machine.short_break_length)
		states.paused:
			state_machine.pomodoro_timer.paused = false
		states.work, states.break:
			state_machine.pomodoro_timer.stop()

	is_break_state = true


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _on_button_pressed(button: Button) -> void:
	match button:
		buttons.stop:
			is_break_state = false
			state_machine.current_round = 1
			finished.emit(states.idle)
		buttons.pause:
			finished.emit(states.paused)
		buttons.skip:
			is_break_state = false
			state_machine.current_round += 1
			finished.emit(states.idle)
		buttons.go_back:
			is_break_state = true
			finished.emit(states.idle)

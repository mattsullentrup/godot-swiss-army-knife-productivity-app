class_name IdleState
extends State


func _enter() -> void:
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = _determine_time_to_display()


func _on_button_pressed(button: Button) -> void:
	match button:
		buttons.start:
			if is_break_state:
				finished.emit(states.break)
			else:
				finished.emit(states.work)
		buttons.skip:
			if is_break_state:
				state_machine.current_round += 1
				is_break_state = false
			else:
				is_break_state = true

			finished.emit(states.idle)
		buttons.go_back:
			if is_break_state == false:
				state_machine.current_round -= 1
				is_break_state = true
			else:
				is_break_state = false

			finished.emit(states.idle)
		buttons.stop:
			_reset_state_machine()
			finished.emit(states.idle)


func _reset_state_machine() -> void:
	state_machine.time_to_display = state_machine.work_round_length
	state_machine.current_round = 1
	is_break_state = false


func _determine_time_to_display() -> float:
	match is_break_state:
		true when state_machine.current_round == state_machine.MAX_ROUND:
			return state_machine.long_break_length
		true:
			return state_machine.short_break_length
		false:
			return state_machine.work_round_length
		_:
			return 0

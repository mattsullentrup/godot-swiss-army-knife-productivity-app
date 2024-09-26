class_name IdleState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	state_machine.time_to_display = _determine_time_to_display()

	state_machine.pomodoro_timer.stop()


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.START:
			finished.emit("Break" if state_machine.is_break_state else "Work")
		ButtonType.SKIP:
			if state_machine.is_break_state:
				state_machine.current_round += 1
				state_machine.is_break_state = false
			else:
				state_machine.is_break_state = true

			finished.emit("Idle")
			_print_status()
		ButtonType.GO_BACK:
			if state_machine.is_break_state == false:
				state_machine.current_round -= 1
				state_machine.is_break_state = true
			else:
				state_machine.is_break_state = false

			finished.emit("Idle")
			_print_status()
		ButtonType.STOP:
			_reset_state_machine()
			finished.emit("idle")


func _print_status() -> void:
	printt(
		"is break state: " + str(state_machine.is_break_state) + ' | ' \
		+ "round: " + str(state_machine.current_round)
	)

func _reset_state_machine() -> void:
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = state_machine.work_round_length
	state_machine.current_round = 1
	state_machine.is_break_state = false


func _determine_time_to_display() -> float:
	match state_machine.is_break_state:
		true when state_machine.current_round == state_machine.MAX_ROUND:
			return state_machine.long_break_length
		true:
			return state_machine.short_break_length
		false:
			return state_machine.work_round_length
		_:
			return 0

	#return -1

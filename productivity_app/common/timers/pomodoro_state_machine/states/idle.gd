class_name IdleState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	state_machine.pomodoro_timer.stop()


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.START:
			finished.emit(ProductivityState.find_key(state_machine.productivity_state))
		ButtonType.SKIP:
			if state_machine.productivity_state == ProductivityState.BREAK:
				state_machine.current_round += 1
				state_machine.productivity_state = ProductivityState.WORK
			else:
				state_machine.productivity_state = ProductivityState.BREAK

			finished.emit("Idle")
			_print_status()
		ButtonType.GO_BACK:
			if state_machine.productivity_state == ProductivityState.WORK:
				state_machine.current_round -= 1
				state_machine.productivity_state = ProductivityState.BREAK
			else:
				state_machine.productivity_state = ProductivityState.WORK

			finished.emit("Idle")
			_print_status()
		ButtonType.STOP:
			_reset_state_machine()


func _print_status() -> void:
	printt(
		ProductivityState.find_key(state_machine.productivity_state) + ' | ' \
		+ "round: " + str(state_machine.current_round)
	)

func _reset_state_machine() -> void:
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = 0.0
	state_machine.current_round = 1
	#state_machine.productivity_state = State.ProductivityState.BREAK

class_name IdleState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	_reset_state_machine()


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.START:
			finished.emit(ProductivityState.find_key(state_machine.productivity_state))
		ButtonType.SKIP:
			finished.emit("Idle")
			if state_machine.productivity_state == ProductivityState.BREAK:
				state_machine.current_round += 1
				state_machine.productivity_state = ProductivityState.WORK
			else:
				state_machine.productivity_state = ProductivityState.BREAK
			#printt(
				#ProductivityState.find_key(state_machine.productivity_state) + ' | ' \
				#+ "round: " + str(state_machine.current_round)
			#)
		ButtonType.GO_BACK:
			finished.emit("Idle")
			if state_machine.productivity_state == ProductivityState.WORK:
				state_machine.current_round -= 1
				state_machine.productivity_state = ProductivityState.BREAK
			else:
				state_machine.productivity_state = ProductivityState.WORK
			#printt(
				#ProductivityState.find_key(state_machine.productivity_state) + ' | ' \
				#+ "round: " + str(state_machine.current_round)
			#)
		ButtonType.STOP:
			_reset_state_machine()


func _reset_state_machine() -> void:
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = 0.0
	state_machine.current_round = 1
	#state_machine.productivity_state = State.ProductivityState.BREAK

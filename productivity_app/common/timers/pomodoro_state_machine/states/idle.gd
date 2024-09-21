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
			finished.emit("Work")
		ButtonType.SKIP:
			if state_machine.productivity_state == ProductivityState.BREAK:
				finished.emit("Work")
				state_machine.current_round += 1
			else:
				finished.emit("Break")
		ButtonType.GO_BACK:
			if state_machine.productivity_state == ProductivityState.BREAK:
				finished.emit("Work")
			else:
				finished.emit("Break")
				state_machine.current_round -= 1


func _reset_state_machine() -> void:
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = 0.0
	state_machine.current_round = 1
	state_machine.productivity_state = State.ProductivityState.BREAK

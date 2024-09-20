class_name OvertimeState
extends State


var _overtime_start_time: float


func _enter(_previous_state: State) -> void:
	super(_previous_state)

	_overtime_start_time = Time.get_unix_time_from_system()

	state_machine.notification_sound.play()
	state_machine.progress_bar.value = 0


func _update() -> void:
	state_machine.time_to_display = (
			_overtime_start_time - Time.get_unix_time_from_system()
	)


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonTypes) -> void:
	match button:
		ButtonTypes.START:
			if state_machine.productivity_state == ProductivityStates.BREAK:
				state_machine.current_round += 1
				finished.emit("Work")
			else:
				finished.emit("Break")
		ButtonTypes.SKIP:
			if state_machine.productivity_state == ProductivityStates.BREAK:
				state_machine.current_round += 1
				finished.emit("Work")
			else:
				finished.emit("Break")
		ButtonTypes.GO_BACK:
			if state_machine.productivity_state == ProductivityStates.BREAK:
				finished.emit("Work")
			else:
				state_machine.current_round -= 1
				finished.emit("Break")
		ButtonTypes.STOP:
			finished.emit("Idle")

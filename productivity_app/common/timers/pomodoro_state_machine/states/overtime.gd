class_name OvertimeState
extends State


var _overtime_start_time: float


func _enter(previous_state: State) -> void:
	super(previous_state)

	_overtime_start_time = Time.get_unix_time_from_system()

	state_machine.notification_sound.play()
	#state_machine.progress_bar.value = 0


func _update() -> void:
	state_machine.time_to_display = (
			_overtime_start_time - Time.get_unix_time_from_system()
	)


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.START:
			if state_machine.is_break_state == true:
				state_machine.current_round += 1
				finished.emit("Work")
			else:
				finished.emit("Break")
		ButtonType.SKIP:
			if state_machine.is_break_state:
				state_machine.current_round += 1
				state_machine.is_break_state = false
			else:
				state_machine.is_break_state = true
			finished.emit("Idle")
		ButtonType.GO_BACK:
			finished.emit("Idle")
		ButtonType.STOP:
			state_machine.is_break_state = false
			finished.emit("Idle")

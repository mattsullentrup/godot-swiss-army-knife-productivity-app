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


func _on_button_pressed(button: Button) -> void:
	match button:
		_start_button:
			if is_break_state == true:
				state_machine.current_round += 1
				finished.emit(work_state)
			else:
				finished.emit(break_state)
		_skip_button:
			if is_break_state:
				state_machine.current_round += 1
				is_break_state = false
			else:
				is_break_state = true
			finished.emit(idle_state)
		_go_back_button:
			finished.emit(idle_state)
		_stop_button:
			is_break_state = false
			finished.emit(idle_state)

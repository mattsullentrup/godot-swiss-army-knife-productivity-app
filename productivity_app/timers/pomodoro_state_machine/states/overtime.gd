class_name OvertimeState
extends State


var _overtime_start_time: float
var _time_passed: float


func _enter() -> void:
	_overtime_start_time = Time.get_unix_time_from_system()

	state_machine.notification_sound.play()
	_time_passed = 0


func _update() -> void:
	_time_passed = _overtime_start_time - Time.get_unix_time_from_system()
	state_machine.time_to_display = _time_passed


func _on_button_pressed(button: Button) -> void:
	match button:
		buttons.start:
			if is_break_state == true:
				state_machine.current_round += 1
				finished.emit(states.work)
			else:
				finished.emit(states.break)
		buttons.skip:
			if is_break_state:
				state_machine.current_round += 1
				is_break_state = false
			else:
				is_break_state = true
			finished.emit(states.idle)
		buttons.go_back:
			finished.emit(states.idle)
		buttons.stop:
			is_break_state = false
			finished.emit(states.idle)

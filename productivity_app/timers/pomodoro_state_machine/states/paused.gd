class_name PausedState
extends State


@export var _time_remaining_label: Label


func _enter() -> void:
	state_machine.pomodoro_timer.paused = true


func _exit() -> void:
	super()
	state_machine.pomodoro_timer.paused = false


func _on_button_pressed(button: Button) -> void:
	match button:
		buttons.pause, buttons.start:
			if is_break_state:
				finished.emit(states.break)
			else:
				finished.emit(states.work)
		buttons.stop:
			is_break_state = false
			state_machine.current_round = 1
			finished.emit(states.idle)
		buttons.skip:
			if is_break_state:
				is_break_state = false
				state_machine.current_round += 1
			else:
				is_break_state = true

			finished.emit(states.idle)
		buttons.go_back:
			finished.emit(states.idle)

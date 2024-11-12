class_name PausedState
extends State


@export var _paused_label: Label


func _ready() -> void:
	_paused_label.text = ""


func _enter() -> void:
	_paused_label.text = "Paused"
	state_machine.pomodoro_timer.paused = true


func _exit() -> void:
	_paused_label.text = ""
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

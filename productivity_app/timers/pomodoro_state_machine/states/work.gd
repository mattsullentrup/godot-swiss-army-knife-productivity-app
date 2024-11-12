class_name WorkState
extends State


@export var _productivity_state_label: Label


func _enter() -> void:
	_productivity_state_label.text = "Work"
	match state_machine.previous_state:
		states.idle, states.overtime:
			state_machine.pomodoro_timer.start(state_machine.work_round_length)
		states.paused:
			state_machine.pomodoro_timer.paused = false
		states.work, states.break:
			state_machine.pomodoro_timer.stop()

	is_break_state = false


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _on_button_pressed(button: Button) -> void:
	match button:
		buttons.stop:
			state_machine.current_round = 1
			finished.emit(states.idle)
		buttons.pause:
			finished.emit(states.paused)
		buttons.skip:
			is_break_state = true
			finished.emit(states.idle)
		buttons.go_back:
			is_break_state = false
			finished.emit(states.idle)

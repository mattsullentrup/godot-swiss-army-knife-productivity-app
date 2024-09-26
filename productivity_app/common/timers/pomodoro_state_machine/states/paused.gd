class_name PausedState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	state_machine.pomodoro_timer.paused = true


func _update() -> void:
	pass


func _exit() -> void:
	super()
	state_machine.pomodoro_timer.paused = false


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.PAUSE, ButtonType.START:
			finished.emit(break_state if state_machine.is_break_state else work_state)
		ButtonType.STOP:
			state_machine.is_break_state = false
			finished.emit(idle_state)
		ButtonType.SKIP:
			if state_machine.is_break_state:
				state_machine.is_break_state = false
				state_machine.current_round += 1
			else:
				state_machine.is_break_state = true

			finished.emit(idle_state)
		ButtonType.GO_BACK:
			finished.emit(idle_state)

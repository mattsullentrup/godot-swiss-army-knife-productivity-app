extends PomodoroState


func _enter(_previous_state: PomodoroState) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.start()


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left

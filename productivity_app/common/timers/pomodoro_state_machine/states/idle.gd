extends PomodoroState


func _enter(_previous_state: PomodoroState) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.stop()
	get_parent().time_to_display = 0

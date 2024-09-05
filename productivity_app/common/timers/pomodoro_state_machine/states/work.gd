extends PomodoroState


func _enter() -> void:
	super()
	state_machine.pomodoro_timer.start()


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left

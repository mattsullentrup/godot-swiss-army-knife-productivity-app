extends PomodoroState


func _enter() -> void:
	super()
	state_machine.pomodoro_timer.stop()
	get_parent().time_to_display = 0

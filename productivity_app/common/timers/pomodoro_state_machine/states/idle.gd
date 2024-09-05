extends PomodoroState


func _enter() -> void:
	super()
	pomodoro_timer.stop()
	get_parent().time_to_display = 0

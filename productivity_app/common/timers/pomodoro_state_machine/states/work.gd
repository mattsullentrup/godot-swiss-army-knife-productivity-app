extends PomodoroState


func _enter() -> void:
	super()
	pomodoro_timer.start()


func _update() -> void:
	get_parent().time_to_display = pomodoro_timer.time_left

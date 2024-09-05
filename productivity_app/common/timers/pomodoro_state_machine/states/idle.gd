extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.stop()
	get_parent().time_to_display = 0


func _on_button_pressed(button: PomodoroStateMachine.ButtonTypes) -> void:
	if button == PomodoroStateMachine.ButtonTypes.START:
		finished.emit("Work")

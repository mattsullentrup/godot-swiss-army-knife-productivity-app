class_name IdleState
extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = 0


#func _on_button_pressed(button: PomodoroStateMachine.ButtonTypes) -> void:
func _on_button_pressed(button: int) -> void:
	if button == ButtonTypes.START:
		finished.emit("Work")

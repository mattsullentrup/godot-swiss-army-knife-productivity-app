class_name WorkState
extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.start()


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _on_button_pressed(button: int) -> void:
	if button == PomodoroStateMachine.ButtonTypes.STOP:
		finished.emit("Idle")

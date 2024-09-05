extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.start()


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _on_button_pressed(_button: PomodoroStateMachine.ButtonTypes) -> void:
	pass

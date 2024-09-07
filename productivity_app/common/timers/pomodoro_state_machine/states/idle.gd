class_name IdleState
extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.stop()
	state_machine.time_to_display = 0


func _exit() -> void:
	super()


func _on_button_pressed(button: int) -> void:
	match button:
		ButtonTypes.START:
			if state_machine.productivity_state == ProductivityStates.BREAK:
				finished.emit("Work")
			else:
				finished.emit("Break")

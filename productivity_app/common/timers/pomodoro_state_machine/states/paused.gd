class_name PausedState
extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)
	state_machine.pomodoro_timer.paused = true


func _update() -> void:
	pass


func _exit() -> void:
	super()

	state_machine.pomodoro_timer.paused = false


func _on_button_pressed(button: ButtonTypes) -> void:
	match button:
		ButtonTypes.PAUSE, ButtonTypes.START:
			if state_machine.productivity_state == ProductivityStates.BREAK:
				finished.emit("Break")
			else:
				finished.emit("Work")

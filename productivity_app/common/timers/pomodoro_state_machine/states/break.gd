class_name BreakState
extends State


func _enter(previous_state: State) -> void:
	match state_machine.states.find_key(previous_state):
		"Idle", "Overtime":
			state_machine.pomodoro_timer.start()
		"Paused":
			state_machine.pomodoro_timer.paused = false
		"Work", "Break":
			state_machine.pomodoro_timer.stop()
		_:
			print("No previous state")

	state_machine.productivity_state = ProductivityState.BREAK

	super(previous_state)


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _exit() -> void:
	super()


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.STOP:
			finished.emit("Idle")
		ButtonType.PAUSE:
			finished.emit("Paused")
		ButtonType.SKIP:
			state_machine.productivity_state = ProductivityState.WORK
			finished.emit("Idle")
		ButtonType.GO_BACK:
			state_machine.productivity_state = ProductivityState.BREAK
			finished.emit("Idle")

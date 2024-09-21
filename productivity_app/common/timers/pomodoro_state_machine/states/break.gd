class_name BreakState
extends State


func _enter(previous_state: State) -> void:
	match state_machine.states.find_key(previous_state):
		"idle", "overtime":
			state_machine.pomodoro_timer.start()
		"paused":
			state_machine.pomodoro_timer.paused = false
		"work", "break":
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
			state_machine.current_round += 1
			state_machine.pomodoro_timer.stop()
			finished.emit("Idle")
		ButtonType.GO_BACK:
			state_machine.productivity_state = ProductivityState.BREAK
			state_machine.pomodoro_timer.stop()
			finished.emit("Idle")

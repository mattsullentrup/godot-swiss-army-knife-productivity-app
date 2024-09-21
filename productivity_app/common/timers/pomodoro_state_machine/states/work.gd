class_name WorkState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)

	match state_machine.states.find_key(previous_state):
		"idle", "overtime":
			state_machine.pomodoro_timer.start()
		"paused":
			state_machine.pomodoro_timer.paused = false

	state_machine.productivity_state = ProductivityStates.WORK


func _update() -> void:
	state_machine.time_to_display = state_machine.pomodoro_timer.time_left


func _exit() -> void:
	super()


func _on_button_pressed(button: int) -> void:
	match button:
		ButtonTypes.STOP:
			finished.emit("Idle")
		ButtonTypes.PAUSE:
			finished.emit("Paused")

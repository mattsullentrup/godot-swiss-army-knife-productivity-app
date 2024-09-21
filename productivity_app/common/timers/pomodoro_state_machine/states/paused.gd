class_name PausedState
extends State


func _enter(previous_state: State) -> void:
	super(previous_state)
	state_machine.pomodoro_timer.paused = true


func _update() -> void:
	pass


func _exit() -> void:
	super()
	state_machine.pomodoro_timer.paused = false


func _on_button_pressed(button: ButtonType) -> void:
	match button:
		ButtonType.PAUSE, ButtonType.START:
			finished.emit(ProductivityState.find_key(state_machine.productivity_state))
		ButtonType.STOP:
			state_machine.productivity_state = ProductivityState.WORK
			finished.emit("Idle")

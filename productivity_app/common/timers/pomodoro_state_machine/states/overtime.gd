class_name OvertimeState
extends State


var _overtime_start_time: float


func _enter(_previous_state: State) -> void:
	super(_previous_state)

	_overtime_start_time = Time.get_unix_time_from_system()

	state_machine.notification_sound.play()
	state_machine.progress_bar.value = 0


func _exit() -> void:
	super()


func _update() -> void:
	get_parent().time_to_display = _overtime_start_time - Time.get_unix_time_from_system()


func _on_button_pressed(_button: PomodoroStateMachine.ButtonTypes) -> void:
	pass

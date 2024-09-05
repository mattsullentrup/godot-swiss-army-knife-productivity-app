class_name State
extends StateMachine


@warning_ignore("unused_signal")
signal finished(next_state: String)

var state_machine: StateMachine


func _enter(_previous_state: State) -> void:
	print("Entering " + self.name)


func _exit() -> void:
	print("Exiting " + self.name)
	print("~~~~~~~~")


func _update() -> void:
	pass


func _on_button_pressed(_button: PomodoroStateMachine.ButtonTypes) -> void:
	pass

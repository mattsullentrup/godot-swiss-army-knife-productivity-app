class_name State
extends Node


@warning_ignore("unused_signal")
signal finished(next_state: String)

enum ButtonType {
	START,
	GO_BACK,
	PAUSE,
	SKIP,
	STOP,
}

enum ProductivityState {
	BREAK,
	WORK,
}

var state_machine: PomodoroStateMachine


func _enter(_previous_state: State) -> void:
	print("Entering " + self.name)


func _update() -> void:
	pass


func _exit() -> void:
	print("Exiting " + self.name)
	print("~~~~~~~~")


func _on_button_pressed(_button: ButtonType) -> void:
	pass

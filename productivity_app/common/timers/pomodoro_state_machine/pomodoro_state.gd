class_name PomodoroState
extends Node


var state_machine: PomodoroStateMachine


func _enter(_previous_state: PomodoroState) -> void:
	print("Entering " + self.name)


func _exit() -> void:
	print("Exiting " + self.name)
	print("~~~~~~~~")


func _update() -> void:
	pass

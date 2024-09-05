class_name PomodoroState
extends Node


@warning_ignore("unused_signal")
signal state_changing(current: PomodoroState, new_state_name: String)

var pomodoro_timer: Timer = null


func _enter() -> void:
	print("Entering " + self.name)


func _exit() -> void:
	print("Exiting " + self.name)
	print("~~~~~~~~")


func _update() -> void:
	pass


#signal finished(next_state_path: String, data: Dictionary)

#func _enter(previous_state_path: String, data: Dictionary) -> void:
	#pass
#
#
#func _exit() -> void:
	#pass

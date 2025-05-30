class_name State
extends Node


@warning_ignore("unused_signal")
signal finished(next_state: State)

static var is_break_state := false

# References
var state_machine: PomodoroStateMachine
var states := {}
var buttons := {}


func _enter() -> void:
	pass


func _update() -> void:
	pass


func _exit() -> void:
	pass


@warning_ignore("unused_parameter")
func _on_button_pressed(button: Button) -> void:
	pass

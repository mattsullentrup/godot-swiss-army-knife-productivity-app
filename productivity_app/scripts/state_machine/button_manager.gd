# This script checks whether the button that was pressed is allowed
# to change the current state then sends a signal with the new state
extends HBoxContainer


signal valid_button_pressed(state)

enum State {
	IDLE,
	PAUSED,
	WORK,
	BREAK,
	OVERTIME,
}

var previous_state : State

@onready var current_state : State = State.IDLE


func _on_start_button_pressed() -> void:
	match current_state:
		State.IDLE:
			valid_button_pressed.emit(State.WORK)


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	pass # Replace with function body.

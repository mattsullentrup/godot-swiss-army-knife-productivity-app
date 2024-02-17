# This script checks whether the button that was pressed is allowed
# to change the current state then sends a signal with the new state
extends HBoxContainer


signal valid_button_pressed(state : PomodoroStates.State)


func _on_start_button_pressed() -> void:
	match Pomodoro.current_state:
		PomodoroStates.State.IDLE when Pomodoro.previous_state == PomodoroStates.State.WORK:
			valid_button_pressed.emit(PomodoroStates.State.BREAK)
		PomodoroStates.State.IDLE when Pomodoro.previous_state == PomodoroStates.State.BREAK:
			valid_button_pressed.emit(PomodoroStates.State.WORK)
		_:
			valid_button_pressed.emit(PomodoroStates.State.WORK)


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	pass # Replace with function body.




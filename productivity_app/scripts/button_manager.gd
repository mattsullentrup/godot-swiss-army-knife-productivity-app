# This script checks whether the button that was pressed is allowed
# to change the current state then sends a signal with the new state
extends HBoxContainer


signal valid_button_pressed(state : Pomodoro.State)


func _on_start_button_pressed() -> void:
	match Pomodoro.current_state:
		Pomodoro.State.IDLE when Pomodoro.previous_state == Pomodoro.State.WORK:
			valid_button_pressed.emit(Pomodoro.State.BREAK)
		Pomodoro.State.IDLE when Pomodoro.previous_state == Pomodoro.State.BREAK:
			valid_button_pressed.emit(Pomodoro.State.WORK)
		_:
			valid_button_pressed.emit(Pomodoro.State.WORK)


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	pass # Replace with function body.




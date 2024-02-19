# This script checks whether the button that was pressed is allowed
# to change the current state then sends a signal with the new state
extends HBoxContainer


signal valid_button_pressed
signal is_going_back_during_overtime


func _on_start_button_pressed() -> void:
	match Pomodoro.current_state:
		Pomodoro.State.OVERTIME:
			if Pomodoro.previous_state == Pomodoro.State.BREAK:
				valid_button_pressed.emit(Pomodoro.State.WORK)
			elif Pomodoro.previous_state == Pomodoro.State.WORK:
				valid_button_pressed.emit(Pomodoro.State.BREAK)
		Pomodoro.State.IDLE:
			valid_button_pressed.emit(Pomodoro.previous_state)
		_:
			print("something got fucked")


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.







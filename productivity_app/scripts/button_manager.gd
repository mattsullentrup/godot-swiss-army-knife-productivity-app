# This script checks whether the button that was pressed is allowed
# to change the current state then sends a signal with the new state
extends HBoxContainer


signal valid_button_pressed(state : Pomodoro.State)


func _on_start_button_pressed() -> void:
	match Pomodoro.current_state:
		Pomodoro.State.OVERTIME:
			if Pomodoro.previous_state == Pomodoro.State.BREAK:
				valid_button_pressed.emit(Pomodoro.State.WORK)
			elif Pomodoro.previous_state == Pomodoro.State.WORK:
				valid_button_pressed.emit(Pomodoro.State.BREAK)
		Pomodoro.State.IDLE:
			#if Pomodoro.previous_state == Pomodoro.State.WORK:
				#valid_button_pressed.emit(Pomodoro.State.WORK)
			valid_button_pressed.emit(Pomodoro.previous_state)
		_:
			print("something got fucked")


func _on_go_back_button_pressed() -> void:
	if Pomodoro.current_state != Pomodoro.State.IDLE:
		valid_button_pressed.emit(Pomodoro.State.IDLE)


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	valid_button_pressed.emit(Pomodoro.State.IDLE)




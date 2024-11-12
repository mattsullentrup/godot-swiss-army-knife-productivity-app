extends Label


var state_machine: PomodoroStateMachine


func _process(_delta: float) -> void:
	text = TimerUtilities.get_formatted_time_from_seconds(
			state_machine.time_to_display
	)

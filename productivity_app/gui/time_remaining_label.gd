extends Control


var state_machine: PomodoroStateMachine

@onready var _time_remaining_label: Label = %TimeRemainingLabel


func _process(_delta: float) -> void:
	_time_remaining_label.text = TimerUtilities.get_formatted_time_from_seconds(
			state_machine.time_to_display
	)

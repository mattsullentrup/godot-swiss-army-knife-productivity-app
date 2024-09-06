extends Control


@onready var _time_remaining_label: Label = %TimeRemainingLabel
@onready var _state_machine: PomodoroStateMachine = get_node("../StateMachine")


func _process(_delta: float) -> void:
	_time_remaining_label.text = get_formatted_time_from_seconds(
			_state_machine.time_to_display
	)


func get_formatted_time_from_seconds(seconds: Variant) -> String:
	var is_negative: bool = false
	if seconds < 0:
		seconds = abs(seconds)
		is_negative = true

	var hours: int = seconds / 3600.0
	seconds -= hours * 3600

	var minutes: int = seconds / 60
	seconds -= minutes * 60

	if is_negative:
		return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)
	else:
		return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)

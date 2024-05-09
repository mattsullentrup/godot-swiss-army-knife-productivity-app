extends Label


var time_to_display: float


func _process(_delta: float) -> void:
	text = get_formatted_time_from_seconds(Pomodoro.time_to_display)


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

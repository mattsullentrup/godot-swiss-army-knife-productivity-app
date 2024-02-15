extends Label


var timer : Timer


func _process(_delta: float) -> void:
	text = get_formatted_time_from_seconds(timer.time_left)


func get_formatted_time_from_seconds(seconds : int) -> String:
	var is_negative : bool = false
	if seconds < 0:
		seconds = abs(seconds)
		is_negative = true

	var hours : int = seconds / 3600
	seconds -= hours * 3600

	var minutes : int = seconds / 60
	seconds -= minutes * 60

	if is_negative:
		return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)
	else:
		return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)

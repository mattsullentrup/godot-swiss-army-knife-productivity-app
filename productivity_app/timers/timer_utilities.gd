class_name TimerUtilities


const SNAPPED_TO = 0.01


static func get_overtime(start_time: float) -> float:
	return start_time - Time.get_unix_time_from_system()


static func get_formatted_time_from_seconds(seconds: Variant) -> String:
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


#static func reminder_interval_passed(overtime: float, delta: float) -> bool:
	#var snapped_time := snappedf(overtime * delta, SNAPPED_TO) / 5.0
	#print(Time.get_unix_time_from_system() - overtime)
	#print(snapped_time)
	#print(is_equal_approx(snapped_time, -1.0))
	#return is_equal_approx(snapped_time, -1.0)

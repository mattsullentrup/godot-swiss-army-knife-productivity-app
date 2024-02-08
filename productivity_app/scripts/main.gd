extends Node


@onready var clock_label: Label = %ClockLabel


func _process(_delta: float) -> void:
	# Convert to american time
	var time := Time.get_time_string_from_system()
	var hour := str(time[0] + time[1])
	var int_hour := int(hour)

	if int_hour > 12:
		int_hour -= 12
		var converted_hour := str(int_hour)

		# Check if it's before 10 PM
		if int_hour < 10:
			time[0] = "0"
			time[1] = converted_hour[0]
		else:
			time[0] = converted_hour[0]
			time[1] = converted_hour[1]

		clock_label.text = time + " PM"
	else:
		clock_label.text = time + " AM"

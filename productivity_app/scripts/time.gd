extends PanelContainer


@onready var clock_label : Label = $ClockLabel
@onready var date_label : Label = $DateLabel
@onready var weekday_label: Label = $WeekdayLabel

var datetime : Dictionary


func _process(_delta: float) -> void:
	#datetime = Returns the current date as a dictionary of keys:
	#year, month, day, weekday, hour, minute, second, and dst (Daylight Savings Time).
	datetime = Time.get_datetime_dict_from_system()
	get_time()
	get_date()
	weekday_label.text = get_weekday()


func get_weekday() -> String:
	var weekday : String

	match datetime.get("weekday"):
		0:
			weekday = "Sunday"
		1:
			weekday = "Monday"
		2:
			weekday = "Tuesday"
		3:
			weekday = "Wednesday"
		4:
			weekday = "Thursday"
		5:
			weekday = "Friday"
		0:
			weekday = "Saturday"

	return weekday


func get_date() -> void:
	date_label.text = str(
			datetime.get("month"), "/",
			datetime.get("day"), "/",
			datetime.get("year")
	)


func get_time() -> void:
	var hour : int = datetime.get("hour")
	var twelve_hour_period := "AM"
	var minute : int= datetime.get("minute")
	var zero := ""

	# Convert to american time
	if hour >= 12:
		# if hour is 12, leave it so it doesn't display as '0'
		if hour > 12:
			hour -= 12
		# If hour is twelve or later, add pm
		twelve_hour_period = "PM"
	else:
		twelve_hour_period = "AM"

	# minute doesn't auto add a zero if it's under 10
	zero = "0" if minute < 10 else ""

	clock_label.text = str(
			hour, ":",
			zero, minute, " ",
			twelve_hour_period
	)

extends Control


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

	# Convert to american time
	if hour > 12:
		hour -= 12

	clock_label.text = str(
			hour, ":",
			datetime.get("minute"), ":",
			datetime.get("second"), " PM"
	)


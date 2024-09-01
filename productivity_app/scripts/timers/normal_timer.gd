extends PanelContainer


@export var timer: Timer
@export var time_remaining_label: Label

@onready var option_button: OptionButton = %TimerOptionButton

var timer_length: float
var overtime_start_time: float
var is_in_overtime := false

@onready var notification_sound: AudioStreamPlayer = %NotificationSound


func _ready() -> void:
	option_button.selected = 0
	for i in range(1, 13):
		option_button.add_item(str(i * 5), i * 5)
	timer_length = option_button.get_selected_id() * 60
	time_remaining_label.text = str(timer_length)


func _process(_delta: float) -> void:
	if not timer.is_stopped():
		time_remaining_label.text = get_formatted_time_from_seconds(timer.time_left)
	elif is_in_overtime:
		var overtime: String = get_formatted_time_from_seconds(overtime_start_time - Time.get_unix_time_from_system())
		time_remaining_label.text = overtime
	else:
		#timer_length = int(timer_length)
		time_remaining_label.text = get_formatted_time_from_seconds(timer_length)


func get_formatted_time_from_seconds(fuck: Variant) -> String:
	#var fuck: int = type_convert(seconds, TYPE_INT)
	var is_negative: bool = false
	if fuck < 0:
		fuck = abs(fuck)
		is_negative = true

	var hours: int = fuck / 3600.0
	fuck -= hours * 3600

	var minutes: int = fuck / 60.0
	fuck -= minutes * 60


	if is_negative:
		return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % fuck)
	else:
		return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % fuck)


func _on_timer_start_button_pressed() -> void:
	timer.stop()
	timer.start(timer_length)
	is_in_overtime = false


func _on_timer_stop_button_pressed() -> void:
	timer.stop()
	is_in_overtime = false


func _on_timer_timeout() -> void:
	notification_sound.play()
	overtime_start_time = Time.get_unix_time_from_system()
	is_in_overtime = true


func _on_timer_option_button_item_selected(index: int) -> void:
	timer_length = option_button.get_item_id(index) * 60
	is_in_overtime = false

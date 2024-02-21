extends PanelContainer


@export var normal_timer : Timer
@export var normal_time_remaining_label : Label
@export var normal_timer_option_button : OptionButton

@onready var normal_timer_length : int = (normal_timer_option_button.selected + 1) * 5
@onready var notification_sound : AudioStreamPlayer = %NotificationSound


func _process(_delta: float) -> void:
	normal_time_remaining_label.text = type_convert(ceilf(normal_timer.time_left), TYPE_STRING)


func _on_normal_timer_start_button_pressed() -> void:
	normal_timer.stop()
	normal_timer.start(normal_timer_length)


func _on_normal_timer_stop_button_pressed() -> void:
	normal_timer.stop()


func _on_normal_timer_timeout() -> void:
	notification_sound.play()


func _on_normal_time_option_button_item_selected(index: int) -> void:
	normal_timer_length = (index + 1) * 5

extends PanelContainer


@onready var timer = %Timer
@onready var timer_label = %TimerLabel
@onready var timer_message = %TimerMessage
@onready var timer_length: int = (%TimeOptionButton.selected + 1) * 5


func _ready() -> void:
	timer_message.hide()


func _process(_delta: float) -> void:
	timer_label.text = type_convert(ceilf(timer.time_left), TYPE_STRING)


func _on_timer_start_button_pressed() -> void:
	timer.stop()
	timer.start(timer_length)
	timer_message.hide()


func _on_timer_timeout() -> void:
	timer_message.show()


func _on_time_option_button_item_selected(index: int) -> void:
	timer_length = (index + 1) * 5


func _on_timer_stop_button_pressed() -> void:
	timer.stop()

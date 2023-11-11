extends Node


@onready var timer = %Timer
@onready var timer_label = %TimerLabel
@onready var timer_message = %TimerMessage


func _ready() -> void:
	timer_message.hide()


func _process(_delta: float) -> void:
	timer_label.text = type_convert(ceilf(timer.time_left), TYPE_STRING)


func _on_timer_button_pressed() -> void:
	timer.start()
	timer_message.hide()


func _on_timer_timeout() -> void:
	timer_message.show()

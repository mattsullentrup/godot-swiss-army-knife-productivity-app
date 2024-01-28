extends TabBar


enum Round {
	FIRST = 1,
	SECOND = 2,
	THIRD = 3,
	FOURTH = 4,
}

@export var pomodoro_round_label: Label
@export var pomodoro_timer: Timer
@export var pomodoro_time_remaining_label: Label
@export var pomodoro_timer_message: Label

@onready var pomodoro_timer_length: int = 25


func _ready() -> void:
	pomodoro_round_label.text = str(Round.FIRST) + '/4'
	pomodoro_timer_message.hide()


func _process(_delta: float) -> void:
	pomodoro_time_remaining_label.text = type_convert(ceilf(pomodoro_timer.time_left), TYPE_STRING)


func _on_pomodoro_timer_start_button_pressed() -> void:
	pomodoro_timer.stop()
	pomodoro_timer.start(pomodoro_timer_length)
	pomodoro_timer_message.hide()


func _on_pomodoro_timer_stop_button_pressed() -> void:
	pomodoro_timer.stop()


func _on_pomodoro_timer_timeout() -> void:
	pomodoro_timer_message.show()


func _on_pomodoro_time_option_button_item_selected(index: int) -> void:
	pomodoro_timer_length = (index + 1) * 5

extends Node


@export var task_button : Button
@export var task_button_2 : Button

@onready var timer = %Timer
@onready var timer_label = %TimerLabel
@onready var timer_message = %TimerMessage
@onready var button_colors = [Color.RED, Color.YELLOW, Color.GREEN]
@onready var current_button_color : int = 1


func _ready() -> void:
	timer_message.hide()
	task_button.self_modulate = button_colors[0]
	task_button_2.self_modulate = button_colors[0]


func _process(_delta: float) -> void:
	timer_label.text = type_convert(ceilf(timer.time_left), TYPE_STRING)


func _on_timer_button_pressed() -> void:
	timer.start()
	timer_message.hide()


func _on_timer_timeout() -> void:
	timer_message.show()


func _on_task_button_pressed() -> void:
	task_button.self_modulate = button_colors[current_button_color % 3]
	current_button_color += 1


func _on_task_button_2_pressed() -> void:
	task_button_2.self_modulate = button_colors[current_button_color % 3]
	current_button_color += 1

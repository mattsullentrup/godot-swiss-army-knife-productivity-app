extends PanelContainer


@export var task_button: Button
@export var task_button_2: Button

@onready var button_colors = [Color.RED, Color.YELLOW, Color.GREEN]
@onready var current_button_color: int = 1

var task_buttons = []


func _ready() -> void:
	task_button.self_modulate = button_colors[0]
	task_button_2.self_modulate = button_colors[0]


func _on_task_button_pressed() -> void:
	task_button.self_modulate = button_colors[current_button_color % 3]
	current_button_color += 1

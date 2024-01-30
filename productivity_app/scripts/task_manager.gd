extends PanelContainer


@export var task_buttons : Array[Button] = []

@onready var button_colors : Array[Color] = [Color.RED, Color.YELLOW, Color.GREEN]
@onready var current_button_color: int = 1


func _ready() -> void:
	for child: HBoxContainer in $VBoxContainer.get_children():
		var button: Button = child.get_child(0)
		button.self_modulate = button_colors[0]
		button.pressed.connect(_on_task_button_pressed.bind(button))


func _on_task_button_pressed(button: Button) -> void:
	button.self_modulate = button_colors[current_button_color % 3]
	current_button_color += 1


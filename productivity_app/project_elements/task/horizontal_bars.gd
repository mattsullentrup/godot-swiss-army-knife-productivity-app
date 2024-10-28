extends TextureRect


var grabbed: bool


func _ready() -> void:
	gui_input.connect(_on_gui_input)


func _on_gui_input(event: InputEvent) -> void:
	var button := event as InputEventMouseButton
	if button == null:
		return

	if button.button_index != MOUSE_BUTTON_LEFT:
		return

	grabbed = button.pressed

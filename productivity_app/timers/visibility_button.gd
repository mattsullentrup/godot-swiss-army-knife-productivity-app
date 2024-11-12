extends Button


const HIDDEN = preload("res://addons/images/GuiVisibilityHidden.svg")
const VISIBLE = preload("res://addons/images/GuiVisibilityVisible.svg")


@onready var _time_remaining_label: Label = %TimeRemainingLabel


func _on_pressed() -> void:
	if _time_remaining_label.visible == true:
		icon = HIDDEN
		_time_remaining_label.hide()
	else:
		_time_remaining_label.show()
		icon = VISIBLE

extends Button


const HIDDEN = preload("res://addons/images/GuiVisibilityHidden.svg")
const VISIBLE = preload("res://addons/images/GuiVisibilityVisible.svg")


@onready var _time_remaining_label: Label = %TimeRemainingLabel


func _on_pressed() -> void:
	if not _time_remaining_label.has_theme_color_override("font_color"):
		icon = HIDDEN
		_time_remaining_label.add_theme_color_override("font_color", Color.TRANSPARENT)
	else:
		_time_remaining_label.remove_theme_color_override("font_color")
		icon = VISIBLE

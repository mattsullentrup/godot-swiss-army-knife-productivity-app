@tool
class_name AutoSizeRichLabel extends RichTextLabel


@export var min_font_size := 8 :
	set(v):
		min_font_size = clampi(v, 1, max_font_size)
		_update()


@export var max_font_size := 56 :
	set(v):
		max_font_size = clampi(v, min_font_size, 191)
		_update()


func _ready() -> void:
	item_rect_changed.connect(_update)


func _set(property: StringName, value: Variant) -> bool:
	# Listen for changes to text
	if property == "text":
		text = value
		_update()
		return true

	return false


func _update() -> void:
	return FontAutoSizer.update_font_size_richlabel(self)

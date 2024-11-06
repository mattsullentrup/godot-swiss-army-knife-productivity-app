class_name ToDoItemActionTextureRect
extends TextureRect


var to_do_item: ToDoItem


#func _get_drag_data(_at_position: Vector2) -> Variant:
	#var preview := to_do_item.duplicate() as ToDoItem
	#if preview == null:
		#return
#
	#preview.modulate = Color(preview.modulate, 0.5)
	#set_drag_preview(preview)

	#var separator: HSeparator = HSeparator.new()
	#separator.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#to_do_item.get_parent().separator = separator
	#to_do_item.get_parent().add_child(separator)

	#return to_do_item

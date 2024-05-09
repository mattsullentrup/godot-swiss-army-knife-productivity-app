class_name Project
extends VBoxContainer


var text: String


func _ready() -> void:
	$HBoxContainer/LineEdit.text = text


func _on_delete_button_pressed() -> void:
	queue_free()


func _on_line_edit_text_changed(new_text: String) -> void:
	text = new_text

class_name Project
extends VBoxContainer


var text := ""


func _ready() -> void:
	$HBoxContainer/LineEdit.text = text


func _on_delete_button_pressed() -> void:
	queue_free()

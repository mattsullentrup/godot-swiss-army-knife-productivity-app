class_name Project
extends VBoxContainer


var text : String


func _ready() -> void:
	$LineEdit.text = text


func _on_delete_button_pressed() -> void:
	queue_free()

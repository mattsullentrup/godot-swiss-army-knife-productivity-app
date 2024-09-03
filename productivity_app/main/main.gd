extends Node


@onready var _noise_v_box_container: VBoxContainer = %NoiseVBoxContainer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit.call_deferred()

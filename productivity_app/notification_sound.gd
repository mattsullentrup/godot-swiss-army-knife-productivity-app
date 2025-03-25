extends AudioStreamPlayer


func _on_alarm_volume_h_slider_value_changed(value: float) -> void:
	volume_db = linear_to_db(value)

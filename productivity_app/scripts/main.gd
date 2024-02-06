extends Node


@onready var clock_label: Label = %ClockLabel


func _process(_delta: float) -> void:
	clock_label.text = Time.get_time_string_from_system()

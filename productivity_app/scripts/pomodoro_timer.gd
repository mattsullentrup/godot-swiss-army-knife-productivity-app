extends TabBar


@export var time_remaining_label : Label


func _ready() -> void:
	time_remaining_label.timer = $PomodoroTimer

	#var fuck := time_remaining_label as Label
	#if fuck != null:
		#fuck.timer = $PomodoroTimer

	#if time_remaining_label is Label:
		#var fuck : Label = time_remaining_label
		#fuck.timer = $PomodoroTimer

	#if "timer" in time_remaining_label:
		#var timer_variant : Variant = time_remaining_label.get("label")
		#if timer_variant is Timer:
			#var timer : Timer = timer_variant
			#timer = $PomodoroTimer

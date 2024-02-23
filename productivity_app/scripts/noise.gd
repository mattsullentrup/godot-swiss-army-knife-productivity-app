extends VBoxContainer


@onready var pink_noise: AudioStreamPlayer = %PinkNoise



func _on_noise_button_toggled(toggled_on: bool) -> void:
	toggled_on = not toggled_on
	pink_noise.playing = toggled_on

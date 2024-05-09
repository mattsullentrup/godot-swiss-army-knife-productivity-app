extends VBoxContainer


@export var audio_off_icon: CompressedTexture2D
@export var audio_on_icon: CompressedTexture2D

@onready var pink_noise: AudioStreamPlayer = %PinkNoise
@onready var volume_h_slider: HSlider = %VolumeHSlider
@onready var noise_button: Button = %NoiseButton


func _ready() -> void:
	pink_noise.volume_db = linear_to_db(volume_h_slider.value)
	pink_noise.playing = true
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Noise"), true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		pink_noise.queue_free()


func _on_noise_button_toggled(toggled_on: bool) -> void:
	# pink_noise.playing = toggled_on
	toggled_on = not toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Noise"), toggled_on)
	noise_button.icon = audio_on_icon if not toggled_on else audio_off_icon


func _on_volume_h_slider_value_changed(value: float) -> void:
	# Use `linear_to_db()` to get a volume slider that matches perceptual human hearing.
	pink_noise.volume_db = linear_to_db(value)

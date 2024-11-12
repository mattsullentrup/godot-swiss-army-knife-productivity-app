class_name NoiseContainer
extends VBoxContainer


const VOLUME = "noise_volume"
const VOLUME_DEFAULT = 0.25


@export var audio_off_icon: CompressedTexture2D
@export var audio_on_icon: CompressedTexture2D

@onready var _pink_noise: AudioStreamPlayer = %PinkNoise
@onready var _volume_slider: HSlider = %VolumeHSlider
@onready var _noise_button: Button = %NoiseButton


func _ready() -> void:
	#_volume_slider.value = Settings.get_value(
			#Settings.NOISE_VOLUME, Settings.NOISE_VOLUME_DEFAULT
	#)
	_volume_slider.value_changed.connect(_on_volume_slider_value_changed)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_pink_noise.stop()
		_pink_noise.queue_free()


func save(save_file: SaveFile) -> void:
	save_file.noise_data[VOLUME] = _volume_slider.value


func load(save_file: SaveFile) -> void:
	if save_file.noise_data.has(VOLUME):
		_volume_slider.value = save_file.noise_data[VOLUME]
	else:
		_volume_slider.value = VOLUME_DEFAULT

	_pink_noise.volume_db = linear_to_db(_volume_slider.value)


func _on_noise_button_toggled(toggled_on: bool) -> void:
	_pink_noise.playing = toggled_on
	_noise_button.icon = audio_on_icon if toggled_on else audio_off_icon


func _on_volume_slider_value_changed(value: float) -> void:
	_pink_noise.volume_db = linear_to_db(value)
	#Settings.set_value(Settings.NOISE_VOLUME, value)

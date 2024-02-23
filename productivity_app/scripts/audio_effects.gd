extends PanelContainer


const RATE_HZ_MAX : float = 20
const RATE_HZ_MIN : float = 0.01

@onready var phaser := AudioServer.get_bus_effect(1, 0) as AudioEffectPhaser
@onready var rate_hz_h_slider : HSlider = $VBoxContainer/GridContainer/RateHzHSlider


func _ready() -> void:
	AudioServer.set_bus_effect_enabled(1, 0, false)

	rate_hz_h_slider.min_value = RATE_HZ_MIN
	rate_hz_h_slider.max_value = RATE_HZ_MAX
	phaser.rate_hz = rate_hz_h_slider.value


func _on_range_min_hz_h_slider_value_changed(value: float) -> void:
	phaser.rate_hz = value


func _on_phaser_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(1, 0, toggled_on)
	toggled_on = not toggled_on

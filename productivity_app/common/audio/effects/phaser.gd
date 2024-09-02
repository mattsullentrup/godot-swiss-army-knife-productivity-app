extends HBoxContainer


const RATE_HZ_MAX: float = 20
const RATE_HZ_MIN: float = 0.01

var phaser_index: int = 0

@onready var effects_bus := AudioServer.get_bus_index("Effects")
@onready var phaser := AudioServer.get_bus_effect(effects_bus, 0) as AudioEffectPhaser
@onready var rate_hz_h_slider: HSlider = %RateHzHSlider


func _ready() -> void:
	AudioServer.set_bus_effect_enabled(effects_bus, phaser_index, false)

	rate_hz_h_slider.min_value = RATE_HZ_MIN
	rate_hz_h_slider.max_value = RATE_HZ_MAX
	phaser.rate_hz = rate_hz_h_slider.value


func _on_range_min_hz_h_slider_value_changed(value: float) -> void:
	phaser.rate_hz = value


func _on_phaser_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(effects_bus, phaser_index, toggled_on)
	toggled_on = not toggled_on

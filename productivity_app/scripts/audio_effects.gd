extends PanelContainer


const RATE_HZ_MAX : float = 20
const RATE_HZ_MIN : float = 0.01

var can_autopan := false
var pan_strength : float = 1
var pan_speed : float = 0.05
var pan_value : float = 0

@onready var phaser := AudioServer.get_bus_effect(1, 0) as AudioEffectPhaser
@onready var panner := AudioServer.get_bus_effect(1, 1) as AudioEffectPanner
@onready var rate_hz_h_slider : HSlider = $VBoxContainer/GridContainer/RateHzHSlider


func _ready() -> void:
	AudioServer.set_bus_effect_enabled(1, 0, false)
	#AudioServer.set_bus_effect_enabled(1, 1, false)

	rate_hz_h_slider.min_value = RATE_HZ_MIN
	rate_hz_h_slider.max_value = RATE_HZ_MAX
	phaser.rate_hz = rate_hz_h_slider.value

	can_autopan = true


func _process(_delta: float) -> void:
	pass
	#if can_autopan:
		#if is_equal_approx(pan_value, pan_strength):
			#pan_speed = -pan_speed
		#elif is_equal_approx(pan_value, -pan_strength):
			#pan_speed = abs(pan_speed)
		#pan_value += 0.1 * pan_speed
		#clampf(pan_value, -1, 1)
		#panner.pan = pan_value
		#print(panner.pan)


func _on_range_min_hz_h_slider_value_changed(value: float) -> void:
	phaser.rate_hz = value


func _on_phaser_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(1, 0, toggled_on)
	toggled_on = not toggled_on


func _on_autopan_check_button_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#%PinkNoise.mix_target = AudioStreamPlayer.MIX_TARGET_CENTER
	#else:
		#%PinkNoise.mix_target = AudioStreamPlayer.MIX_TARGET_STEREO
	AudioServer.set_bus_effect_enabled(1, 1, toggled_on)
	toggled_on = not toggled_on
	can_autopan = not can_autopan


func _on_autopan_slider_value_changed(value: float) -> void:
	pan_strength = value
	#pan_value = 0

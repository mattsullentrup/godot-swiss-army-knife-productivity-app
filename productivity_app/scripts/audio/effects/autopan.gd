extends HBoxContainer


@export var pan_speed : float = 0.0005

var can_autopan := false
var panner_index : int = 1

@onready var effects_bus_index := AudioServer.get_bus_index("Effects")
@onready var noise_bus_index := AudioServer.get_bus_index("Noise")
@onready var panner := AudioServer.get_bus_effect(effects_bus_index, 1) as AudioEffectPanner


func _ready() -> void:
	AudioServer.set_bus_effect_enabled(effects_bus_index, panner_index, false)


func _process(_delta: float) -> void:
	if can_autopan and not AudioServer.is_bus_mute(noise_bus_index):
		if panner.pan > 1:
			pan_speed = -pan_speed
		if panner.pan < -1:
			pan_speed = abs(pan_speed)
		panner.pan += pan_speed
		clampf(panner.pan, -1, 1)
		print(panner.pan)


func _on_autopan_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(effects_bus_index, panner_index, toggled_on)
	toggled_on = not toggled_on
	can_autopan = not can_autopan
	if can_autopan == false:
		panner.pan = 0


func _on_autopan_slider_value_changed(value: float) -> void:
	pan_speed = value

extends HBoxContainer


const PANNER_INDEX = 1

@export var pan_speed: float = 0.0005

var can_autopan := false

@onready var effects_bus_index := AudioServer.get_bus_index("Effects")
@onready var noise_bus_index := AudioServer.get_bus_index("Noise")
@onready var panner: AudioEffectPanner = AudioServer.get_bus_effect(effects_bus_index, PANNER_INDEX)


func _process(delta: float) -> void:
	if can_autopan and not AudioServer.is_bus_mute(noise_bus_index):
		if panner.pan > 1:
			pan_speed = -pan_speed
		if panner.pan < -1:
			pan_speed = abs(pan_speed)
		panner.pan += pan_speed * delta
		clampf(panner.pan, -1, 1)


func save(save_file: SaveFile) -> void:
	save_file.autopan_value = abs(pan_speed)
	save_file.autopan_toggled_on = can_autopan


func load(save_file: SaveFile) -> void:
	pan_speed = save_file.autopan_value
	#can_autopan = save_file.autopan_toggled_on

	#AudioServer.set_bus_effect_enabled(effects_bus_index, PANNER_INDEX, can_autopan)
	$AutopanCheckBox.button_pressed = save_file.autopan_toggled_on
	$AutopanSlider.value = pan_speed


func _on_autopan_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(effects_bus_index, PANNER_INDEX, toggled_on)
	#toggled_on = not toggled_on
	can_autopan = not can_autopan
	if can_autopan == false:
		panner.pan = 0


func _on_autopan_slider_value_changed(value: float) -> void:
	pan_speed = value

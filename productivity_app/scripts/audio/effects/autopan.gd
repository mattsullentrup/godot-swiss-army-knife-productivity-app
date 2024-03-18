extends HBoxContainer


@export var phaser_manager : HBoxContainer

var can_autopan := false
var pan_strength : float = 1
var pan_speed : float = 0.05
var pan_value : float = 0

var panner_index : int = 1

@onready var effects_bus := AudioServer.get_bus_index("Effects")
@onready var panner := AudioServer.get_bus_effect(effects_bus, 1) as AudioEffectPanner


func _ready() -> void:
	AudioServer.set_bus_effect_enabled(effects_bus, panner_index, false)

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





func _on_autopan_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_effect_enabled(effects_bus, panner_index, toggled_on)
	toggled_on = not toggled_on
	can_autopan = not can_autopan


func _on_autopan_slider_value_changed(value: float) -> void:
	pan_strength = value
	#pan_value = 0

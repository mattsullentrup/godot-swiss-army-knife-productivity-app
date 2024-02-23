extends Control


const VU_COUNT : int = 16
const FREQ_MAX : float = 11050.0

const WIDTH : int = 600
const HEIGHT : int = 150
const HEIGHT_SCALE : float = 10.0
const MIN_DB : int = 60
const ANIMATION_SPEED : float = 0.1

# my addition:
const MAGNITUDE_MULTIPLIER : int = 5

var spectrum : AudioEffectInstance
var min_values := []
var max_values := []


func _draw() -> void:
	@warning_ignore("integer_division")
	var w := WIDTH / VU_COUNT
	for i in range(VU_COUNT):
		var min_height : float = min_values[i]
		var max_height : float = max_values[i]
		var height : float = lerp(min_height, max_height, ANIMATION_SPEED)

		draw_rect(
				Rect2(w * i, HEIGHT - height, w - 2, height),
				Color.from_hsv(float(VU_COUNT * 0.6 + i * 0.5) / VU_COUNT, 0.5, 0.6)
		)
		draw_line(
				Vector2(w * i, HEIGHT - height),
				Vector2(w * i + w - 2, HEIGHT - height),
				Color.from_hsv(float(VU_COUNT * 0.6 + i * 0.5) / VU_COUNT, 0.5, 1.0),
				2.0,
				true
		)

		# Draw a reflection of the bars with lower opacity.
		draw_rect(
				Rect2(w * i, HEIGHT, w - 2, height),
				Color.from_hsv(float(VU_COUNT * 0.6 + i * 0.5) / VU_COUNT, 0.5, 0.6) * Color(1, 1, 1, 0.125)
		)
		draw_line(
				Vector2(w * i, HEIGHT + height),
				Vector2(w * i + w - 2, HEIGHT + height),
				Color.from_hsv(float(VU_COUNT * 0.6 + i * 0.5) / VU_COUNT, 0.5, 1.0) * Color(1, 1, 1, 0.125),
				2.0,
				true
		)


func _process(_delta : float) -> void:
	var data := []
	var prev_hz : float = 0

	for i in range(1, VU_COUNT + 1):
		var hz := i * FREQ_MAX / VU_COUNT
		var magnitude : float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length() * MAGNITUDE_MULTIPLIER
		var energy := clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height := energy * HEIGHT * HEIGHT_SCALE
		data.append(height)
		prev_hz = hz

	for i in range(VU_COUNT):
		if data[i] > max_values[i]:
			max_values[i] = data[i]
		else:
			max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)

		if data[i] <= 0.0:
			min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)

	# Sound plays back continuously, so the graph needs to be updated every frame.
	queue_redraw()


func _ready() -> void:
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	min_values.resize(VU_COUNT)
	max_values.resize(VU_COUNT)
	min_values.fill(0.0)
	max_values.fill(0.0)

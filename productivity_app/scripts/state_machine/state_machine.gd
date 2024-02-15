extends Node


@export var initial_state : State
@export var timer : Timer

var current_state : State
var states : Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transitioned)
			child.timer = timer

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _on_child_transitioned(state: State, new_state_name) -> void:
	# Make sure state calling this function is not the current state
	if state != current_state:
		return

	# Get new state from dictionary and make sure it exists
	var new_state : State = states.get(new_state_name.to_lower())
	if not new_state:
		return

	# Check if there already is a current state and exit it if so
	if current_state:
		current_state.exit()

	new_state.enter()

	current_state = new_state


func _on_start_button_pressed() -> void:
	pass

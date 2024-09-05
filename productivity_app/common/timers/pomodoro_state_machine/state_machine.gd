class_name StateMachine
extends Node


@export var initial_state: Node

var states: Dictionary = {}
var current_state: State = null
var previous_state: State = null


func _setup_states() -> void:
	if initial_state == null:
		initial_state = get_child(0)

	for child in get_children():
		if child is State:
			var state: State = child
			states[state.name.to_lower()] = state
			initialize(state)
			continue

		push_error("Child" + child.name + " is not a State")

	change_state(initial_state.name)


func initialize(state: State) -> void:
	state.state_machine = self
	state.finished.connect(change_state)


func change_state(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	if not new_state or current_state == new_state:
		return

	if current_state:
		current_state._exit()

	previous_state = current_state
	current_state = new_state
	current_state._enter(previous_state)

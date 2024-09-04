class_name PomodoroStateMachine
extends Node

@export var initial_state: PomodoroState = null

@onready var state: PomodoroState = (func get_initial_state() -> PomodoroState:
		return initial_state if initial_state != null else get_child(0)
).call()


func _ready() -> void:
	for state_node: PomodoroState in find_children("*", "PomodorState"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")


func _transition_to_next_state(target_state_path: String, data: Dictionary) -> void:
	if not has_node(target_state_path):
		printerr(
				owner.name + ": Trying to transition to state " + target_state_path\
				+ "but it does not exist."
		)
		return

	var previous_state_path := state.name
	state._exit()
	state = get_node(target_state_path)
	state._enter(previous_state_path, data)

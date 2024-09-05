class_name PomodoroStateMachine
extends Node

#@export var initial_state: PomodoroState = null
#
#@onready var state: PomodoroState = (func get_initial_state() -> PomodoroState:
		#return initial_state if initial_state != null else get_child(0)
#).call()
#
#
#func _ready() -> void:
	#for state_node: PomodoroState in find_children("*", "PomodorState"):
		#state_node.finished.connect(_transition_to_next_state)
#
	#await owner.ready
	#state.enter("")
#
#
#func _transition_to_next_state(target_state_path: String, data: Dictionary) -> void:
	#if not has_node(target_state_path):
		#printerr(
				#owner.name + ": Trying to transition to state " + target_state_path\
				#+ "but it does not exist."
		#)
		#return
#
	#var previous_state_path := state.name
	#state._exit()
	#state = get_node(target_state_path)
	#state._enter(previous_state_path, data)


@export var initial_state: Node

static var time_to_display: float

var states: Dictionary = {}
var current_state: PomodoroState = null
var previous_state: PomodoroState = null

@onready var _pomodoro_timer: Timer = %PomodoroTimer


func _ready() -> void:
	if initial_state == null:
		initial_state = get_child(0)

	for child in get_children():
		if child is PomodoroState:
			var state: PomodoroState = child
			states[state.name.to_lower()] = state
			initialize(state)
			continue

		push_error("Child" + child.name + " is not a State")

	change_state(null, initial_state.name)


func _process(_delta: float) -> void:
	current_state._update()

	#if not _pomodoro_timer.is_stopped():
		#progress_bar.value = progress_bar.max_value - _pomodoro_timer.time_left
		#time_to_display = _pomodoro_timer.time_left


func initialize(state: PomodoroState) -> void:
	state.connect("state_changing", _on_state_changing)
	state.pomodoro_timer = _pomodoro_timer


func change_state(source_state: PomodoroState, new_state_name: String) -> void:
	var new_state: PomodoroState = states.get(new_state_name.to_lower())
	if not new_state or current_state == new_state:
		return

	if current_state:
		current_state._exit()

	previous_state = source_state
	current_state = new_state
	current_state._enter()


func _on_state_changing(source_state: PomodoroState, new_state_name: String) -> void:
	change_state(source_state, new_state_name)


func _on_start_button_pressed() -> void:
	change_state(current_state, "Work")


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	change_state(current_state, "Idle")


func _on_pomodoro_timer_timeout() -> void:
	pass # Replace with function body.

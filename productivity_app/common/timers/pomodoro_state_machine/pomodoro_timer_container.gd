extends PanelContainer


var _progress_bar: ProgressBar
var _gui_v_box_container: VBoxContainer
var _round_label: Label
var _paused_label: Label
var _productivity_state_label: Label
var _time_remaining_label: Label

@onready var _state_machine: PomodoroStateMachine = %StateMachine
@onready var _pomodoro_timer: Timer = %PomodoroTimer


func _enter_tree() -> void:
	_progress_bar = %ProgressBar
	_gui_v_box_container = $GUIVBoxContainer
	_round_label = %RoundLabel
	_paused_label = %PausedLabel
	_productivity_state_label = %ProductivityStateLabel
	_time_remaining_label = %TimeRemainingLabel


func _ready() -> void:
	_gui_v_box_container.state_machine = _state_machine


func _process(_delta: float) -> void:
	_time_remaining_label.text = str(_state_machine.time_to_display)
	_progress_bar.value = _progress_bar.max_value - _pomodoro_timer.time_left


func _on_state_machine_round_changed(new_round: Variant) -> void:
	_round_label.text = str(new_round) + '/4'


func _on_state_machine_state_changed(
		new_state: State,
		is_break_state: bool,
		progress_bar_max_value: float
) -> void:
	_paused_label.visible = new_state == PausedState
	_productivity_state_label.text = "Break" if is_break_state else "Work"
	_progress_bar.max_value = progress_bar_max_value

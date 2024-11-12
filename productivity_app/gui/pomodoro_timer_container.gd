extends PanelContainer


var _progress_bar: ProgressBar
var _gui_v_box_container: VBoxContainer
var _round_label: Label

@onready var _state_machine: PomodoroStateMachine = %StateMachine
@onready var _pomodoro_timer: Timer = %PomodoroTimer


func _enter_tree() -> void:
	_progress_bar = %ProgressBar
	_gui_v_box_container = $GUIVBoxContainer
	_round_label = %RoundLabel


func _ready() -> void:
	_gui_v_box_container.state_machine = _state_machine


func _process(_delta: float) -> void:
	_progress_bar.value = _progress_bar.max_value - _pomodoro_timer.time_left


func _on_state_machine_round_changed(new_round: Variant) -> void:
	_round_label.text = str(new_round) + '/4'


func _on_state_machine_state_changed(progress_bar_max_value: float) -> void:
	_progress_bar.max_value = progress_bar_max_value

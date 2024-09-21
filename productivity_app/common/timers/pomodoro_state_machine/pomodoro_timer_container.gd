extends PanelContainer


var _progress_bar: ProgressBar
var _gui_v_box_container: VBoxContainer
var _round_label: Label
var _paused_label: Label
var _productivity_state_label: Label

@onready var _state_machine: PomodoroStateMachine = %StateMachine


func _enter_tree() -> void:
	_progress_bar = %ProgressBar
	_gui_v_box_container = $GUIVBoxContainer
	_round_label = %RoundLabel
	_paused_label = %PausedLabel
	_productivity_state_label = %ProductivityStateLabel


func _ready() -> void:
	_gui_v_box_container.state_machine = _state_machine


func _process(_delta: float) -> void:
	%TimeRemainingLabel.text = str(_state_machine.time_to_display)


func _on_state_machine_round_changed(new_round: Variant) -> void:
	_round_label.text = str(new_round) + '/4'


func _on_state_machine_state_changed(new_state_name: String) -> void:
	if new_state_name == "Paused":
		_paused_label.show()
	else:
		_paused_label.hide()

extends PanelContainer


var _progress_bar: ProgressBar


func _enter_tree() -> void:
	_progress_bar = %ProgressBar


func _ready() -> void:
	%TimeRemainingLabel.state_machine = %StateMachine


func _process(_delta: float) -> void:
	_progress_bar.value = _progress_bar.max_value - %PomodoroTimer.time_left


func _on_state_machine_round_changed(new_round: Variant) -> void:
	%RoundLabel.text = str(new_round) + '/4'


func _on_state_machine_state_changed(progress_bar_max_value: float) -> void:
	_progress_bar.max_value = progress_bar_max_value

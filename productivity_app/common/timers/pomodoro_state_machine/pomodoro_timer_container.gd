extends PanelContainer


var _progress_bar: ProgressBar
var _gui_v_box_container: VBoxContainer
var _round_label: Label


func _enter_tree() -> void:
	_progress_bar = %ProgressBar
	_gui_v_box_container = $GUIVBoxContainer
	_round_label = %RoundLabel


func _ready() -> void:
	_gui_v_box_container.state_machine = $StateMachine


func _on_state_machine_round_changed(new_round: Variant) -> void:
	_round_label.text = str(new_round) + '/4'
	#print(new_round)

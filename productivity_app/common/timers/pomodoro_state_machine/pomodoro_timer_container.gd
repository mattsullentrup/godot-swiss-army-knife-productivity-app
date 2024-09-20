extends PanelContainer


func _process(_delta: float) -> void:
	$GUIVBoxContainer.state_machine = $StateMachine


func _on_state_machine_round_changed(new_round: Variant) -> void:
	%RoundLabel.text = str(new_round) + '/4'
	print(new_round)

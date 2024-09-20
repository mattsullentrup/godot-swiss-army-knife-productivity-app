extends PanelContainer


func _process(_delta: float) -> void:
	$GUIVBoxContainer.state_machine = $StateMachine

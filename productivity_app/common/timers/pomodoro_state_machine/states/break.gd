class_name BreakState
extends State


func _enter(_previous_state: State) -> void:
	super(_previous_state)

	state_machine.productivity_state = ProductivityStates.BREAK


func _update() -> void:
	pass


func _exit() -> void:
	super()


func _on_button_pressed(_button: ButtonTypes) -> void:
	pass

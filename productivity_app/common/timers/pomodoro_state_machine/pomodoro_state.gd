class_name State
extends StateMachine


var state_machine: StateMachine


func _enter(_previous_state: State) -> void:
	print("Entering " + self.name)


func _exit() -> void:
	print("Exiting " + self.name)
	print("~~~~~~~~")


func _update() -> void:
	pass

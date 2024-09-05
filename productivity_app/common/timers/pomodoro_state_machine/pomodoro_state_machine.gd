class_name PomodoroStateMachine
#extends "res://common/timers/pomodoro_state_machine/state_machine.gd"
extends StateMachine


enum Round {
	ZERO,
	FIRST,
	SECOND,
	THIRD,
	FOURTH,
}

enum ProductivityState {
	BREAK,
	WORK,
}

const MINUTE_MULTIPLIER = 60

static var time_to_display: float

var notification_sound: AudioStreamPlayer = null
var productivity_state: int
var timer_length: float

@onready var pomodoro_timer: Timer = %PomodoroTimer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var short_break_length: float = 5
@onready var long_break_length: float = 15
@onready var work_round_length: float = 25
@onready var current_round: int


func _ready() -> void:
	_setup_states()


func _process(_delta: float) -> void:
	current_state._update()


func _get_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	#round_label.text = str(current_round) + '/4'


func _on_start_button_pressed() -> void:
	change_state("Work")
#
	#match current_state:
		#states["Overtime"]:
			#if productivity_state == ProductivityState.BREAK:
				#change_state("Work")
			#else:
				#change_state("Work")
		#states["Idle"]:
			#change_state(ProductivityState.get(productivity_state))
		#_:
			#print("start button unavailable")


func _on_go_back_button_pressed() -> void:
	pass # Replace with function body.


func _on_pause_button_pressed() -> void:
	pass # Replace with function body.


func _on_skip_button_pressed() -> void:
	pass # Replace with function body.


func _on_stop_button_pressed() -> void:
	change_state("Idle")


func _on_pomodoro_timer_timeout() -> void:
	change_state("Overtime")

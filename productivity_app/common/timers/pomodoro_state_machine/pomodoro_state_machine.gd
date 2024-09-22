class_name PomodoroStateMachine
extends StateMachine


signal round_changed(new_round: int)
signal state_changed(new_state_name: String, productivity_state: State.ProductivityState)

const MINUTE_MULTIPLIER = 60
const MAX_ROUND = 5

var notification_sound: AudioStreamPlayer = null
var short_break_length: float = 5
var long_break_length: float = 15
var work_round_length: float = 25
var time_to_display: float
var timer_length: float

var productivity_state := State.ProductivityState.WORK
var current_round: int:
	set(value):
		current_round = value
		current_round = wrap(current_round, 1, MAX_ROUND)
		round_changed.emit(current_round)

@onready var pomodoro_timer: Timer = %PomodoroTimer


func _ready() -> void:
	current_round = 1
	_setup_states()
	_connect_buttons()


func _process(_delta: float) -> void:
	current_state._update()


func _change_state(new_state_name: String) -> void:
	super(new_state_name)
	state_changed.emit(new_state_name, productivity_state)


func _connect_buttons() -> void:
	for button: Button in %Buttons.get_children():
		button.pressed.connect(func () -> void:
				current_state._on_button_pressed(button.get_index())
		)


func _on_pomodoro_timer_timeout() -> void:
	_change_state("Overtime")

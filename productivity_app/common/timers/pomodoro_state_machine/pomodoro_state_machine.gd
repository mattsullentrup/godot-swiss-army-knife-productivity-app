class_name PomodoroStateMachine
extends StateMachine


enum Round {
	ZERO,
	FIRST,
	SECOND,
	THIRD,
	FOURTH,
}

const MINUTE_MULTIPLIER = 60

var notification_sound: AudioStreamPlayer = null
var time_to_display: float
var timer_length: float
var productivity_state := State.ProductivityStates.BREAK
var current_round: Round

@onready var round_label: Label = %RoundLabel
@onready var pomodoro_timer: Timer = %PomodoroTimer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var short_break_length: float = 5
@onready var long_break_length: float = 15
@onready var work_round_length: float = 25


func _ready() -> void:
	_setup_states()
	_connect_buttons()


func _process(_delta: float) -> void:
	current_state._update()


func _change_state(new_state_name: String) -> void:
	super(new_state_name)
	_get_current_round()


func _get_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	round_label.text = str(current_round) + '/4'


func _connect_buttons() -> void:
	for button: Button in %Buttons.get_children():
		button.pressed.connect(func () -> void:
				current_state._on_button_pressed(button.get_index())
		)


func _on_pomodoro_timer_timeout() -> void:
	_change_state("Overtime")
	notification_sound.play()

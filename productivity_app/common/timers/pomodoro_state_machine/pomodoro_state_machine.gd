class_name PomodoroStateMachine
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

enum ButtonTypes {
	START,
	GO_BACK,
	PAUSE,
	SKIP,
	STOP,
}

const MINUTE_MULTIPLIER = 60

var notification_sound: AudioStreamPlayer = null
var productivity_state: int
var time_to_display: float
var timer_length: float

@onready var pomodoro_timer: Timer = %PomodoroTimer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var short_break_length: float = 5
@onready var long_break_length: float = 15
@onready var work_round_length: float = 25
@onready var current_round: int


func _ready() -> void:
	_setup_states()
	_connect_buttons()


func _process(_delta: float) -> void:
	current_state._update()


func _get_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	#round_label.text = str(current_round) + '/4'


func _connect_buttons() -> void:
	for button: Button in %Buttons.get_children():
		button.pressed.connect(_on_button_pressed.bind(button.get_index()))


func _on_button_pressed(button_index: int) -> void:
	#var keys = ButtonTypes.keys()
	#var values = ButtonTypes.values()
	var button_type = ButtonTypes.find_key(button_index)
	current_state._on_button_pressed(button_type)


func _on_start_button_pressed() -> void:
	current_state._on_button_pressed(ButtonTypes.START)


func _on_go_back_button_pressed() -> void:
	current_state._on_button_pressed(ButtonTypes.GO_BACK)


func _on_pause_button_pressed() -> void:
	current_state._on_button_pressed(ButtonTypes.PAUSE)


func _on_skip_button_pressed() -> void:
	current_state._on_button_pressed(ButtonTypes.SKIP)


func _on_stop_button_pressed() -> void:
	current_state._on_button_pressed(ButtonTypes.STOP)


func _on_pomodoro_timer_timeout() -> void:
	change_state("Overtime")

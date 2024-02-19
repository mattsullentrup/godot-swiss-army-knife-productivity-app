class_name Pomodoro
extends TabBar


enum Round { FIRST, SECOND, THIRD, FOURTH }
enum State {
	IDLE,
	PAUSED,
	WORK,
	BREAK,
	OVERTIME,
}

@export var initial_state : State

@export_group("References")
@export var pomodoro_timer : Timer

@export_subgroup("Labels")
@export var round_label : Label
@export var timer_message : Label
@export var paused_message : Label

@export_group("Timer Lengths")
@export var short_break_length : float = 7
@export var long_break_length : float = 1
@export var work_round_length : float = 5

# set this to work to avoid confusion when first starting application
# specifically when pressing play when the current state is IDLE
static var previous_state := State.WORK

static var _time_to_display : float
static var time_to_display : float:
	get:
		return _time_to_display

static var current_state := State.IDLE

var overtime_start_time : float
var overtime_count : float
var timer_length : float
var current_round : Round


@onready var start_button : Button = %StartButton
@onready var notification_sound : AudioStreamPlayer = %NotificationSound
@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
@onready var button_manager: HBoxContainer = %ButtonManager


func _ready() -> void:
	#change_state(initial_state)

	button_manager.valid_button_pressed.connect(change_state)
	progress_bar.value = progress_bar.max_value
	timer_length = work_round_length
	_time_to_display = timer_length


func _process(_delta: float) -> void:
	if not pomodoro_timer.is_stopped():
		progress_bar.value = pomodoro_timer.time_left
		_time_to_display = pomodoro_timer.time_left
	elif current_state == State.OVERTIME:
		_time_to_display = overtime_start_time - Time.get_unix_time_from_system()
	#else:
		#_time_to_display = 0


func change_state(new_state : State) -> void:
	timer_message.show()
	#timer_message.text = set_timer_message(new_state)

	match new_state:
		State.WORK:
			timer_length = work_round_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Work"
			progress_bar.max_value = timer_length
		State.BREAK:
			timer_length = short_break_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Break"
			progress_bar.max_value = timer_length
		State.OVERTIME:
			overtime_start_time = Time.get_unix_time_from_system()
			notification_sound.play()
			progress_bar.value = 0

			if current_state == State.WORK:
				timer_message.text = "Take a break"
			elif current_state == State.BREAK:
				timer_message.text = "Get back to it"
		State.PAUSED:
			timer_message.text = "Paused"
		State.IDLE:
			pomodoro_timer.stop()
			timer_message.hide()
			progress_bar.value = progress_bar.max_value
			_time_to_display = timer_length


	previous_state = current_state
	current_state = new_state

	for item : String in State:
		if State.find_key(current_state):
			print("current: ", State.find_key(current_state))

	for item : String in State:
		if State.find_key(previous_state):
			print("previous: ", State.find_key(previous_state))


func revert_to_previous_state() -> void:
	current_state = previous_state
	progress_bar.max_value = timer_length
	progress_bar.value = pomodoro_timer.time_left
	_time_to_display = timer_length


func _on_button_manager_valid_button_pressed(state : State) -> void:
	change_state(state)


func _on_pomodoro_timer_timeout() -> void:
	change_state(State.OVERTIME)


func _on_go_back_button_pressed() -> void:
	if current_state != State.IDLE:
		if current_state == State.OVERTIME:
			# swap current and previous if in overtime
			# or else it will start at overtime when pressing play again
			revert_to_previous_state()
		change_state(State.IDLE)


func _on_stop_button_pressed() -> void:
	if current_state != State.IDLE:
		change_state(State.IDLE)

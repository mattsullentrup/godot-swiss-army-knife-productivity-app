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
	#set(value):
		#return set_time_to_display

static var _current_state := State.IDLE
static var current_state : State:
	get:
		return _current_state

#var is_exiting_idle_state := false
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


func _process(_delta: float) -> void:
	if not pomodoro_timer.is_stopped():
		progress_bar.max_value = timer_length
		progress_bar.value = pomodoro_timer.time_left
		_time_to_display = pomodoro_timer.time_left
	elif _current_state == State.OVERTIME:
		_time_to_display = overtime_start_time - Time.get_unix_time_from_system()
	else:
		_time_to_display = 0


func change_state(new_state : State, is_exiting_idle_state : bool) -> void:
	#timer_message.text = set_timer_message(new_state)

	match new_state:
		State.WORK:
			timer_length = work_round_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Work"
		State.BREAK:
			timer_length = short_break_length
			pomodoro_timer.start(timer_length)
			timer_message.text = "Break"
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

	timer_message.show()

	previous_state = _current_state
	_current_state = new_state


#func set_time_to_display() -> float:
	#var value : float
#
	#match _current_state:
		#State.OVERTIME:
			#value = overtime_start_time - Time.get_unix_time_from_system()
		#State.IDLE when previous_state == State.IDLE:
			#value = timer_length
		#State.WORK, State.BREAK:
			#value = pomodoro_timer.time_left
#
	#return value


#func set_timer_message(new_state : State) -> String:
	#var new_message : String
#
	#match new_state:
		#State.WORK:
			#new_message = "Work"
		#State.BREAK:
			#new_message = "Break"
		#State.OVERTIME:
			#if current_state == State.WORK:
				#new_message = "Take a break"
			#elif current_state == State.BREAK:
				#new_message = "Get back to it"
#
	#return new_message


func _on_button_manager_valid_button_pressed(state : State, is_exiting_idle_state : bool) -> void:
	change_state(state, is_exiting_idle_state)


func _on_pomodoro_timer_timeout() -> void:
	change_state(State.OVERTIME, false)

class_name Pomodoro
extends PanelContainer


enum Round { ZERO, FIRST, SECOND, THIRD, FOURTH }
enum PomoState {
	IDLE,
	PAUSED,
	WORK,
	BREAK,
	OVERTIME,
}

@export var initial_state: PomoState
@export var pomodoro_timer: Timer

@export_group("Labels")
@export var round_label: Label
@export var timer_message: Label
@export var paused_message: Label

static var _time_to_display: float
static var time_to_display: float:
	get:
		return _time_to_display

var current_state: PomoState = PomoState.IDLE
var productivity_state: PomoState = PomoState.WORK
var overtime_start_time: float
var timer_length: float

@onready var short_break_length: float = 5 * 60
@onready var long_break_length: float = 15 * 60
@onready var work_round_length: float = 25 * 60
@onready var current_round: int
@onready var start_button := %StartButton
@onready var notification_sound: AudioStreamPlayer = %NotificationSound
@onready var progress_bar := %ProgressBar


func _ready() -> void:
	progress_bar.value = 0
	timer_length = work_round_length
	_time_to_display = timer_length
	timer_message.text = "Work" if productivity_state == PomoState.WORK else "Break"
	determine_break_length_to_display()
	check_current_round()


func _process(_delta: float) -> void:
	if not pomodoro_timer.is_stopped():
		progress_bar.value = progress_bar.max_value - pomodoro_timer.time_left
		_time_to_display = pomodoro_timer.time_left
	elif current_state == PomoState.OVERTIME:
		_time_to_display = overtime_start_time - Time.get_unix_time_from_system()


func change_state(new_state: PomoState) -> void:
	timer_message.show()
	paused_message.hide()

	match new_state:
		PomoState.WORK:
			pomodoro_timer.paused = false
			if current_state == PomoState.PAUSED:
				paused_message.hide()
			else:
				if current_state != PomoState.IDLE:
					current_round += 1
				check_current_round()
				timer_length = work_round_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Work"
				productivity_state = PomoState.WORK
		PomoState.BREAK:
			pomodoro_timer.paused = false
			if current_state == PomoState.PAUSED:
				paused_message.hide()
			else:
				if current_round == Round.FOURTH:
					timer_length = long_break_length
				else:
					timer_length = short_break_length
				pomodoro_timer.start(timer_length)
				progress_bar.max_value = timer_length
				timer_message.text = "Break"
				productivity_state = PomoState.BREAK
		PomoState.PAUSED:
			pomodoro_timer.paused = true
			paused_message.show()
		PomoState.OVERTIME:
			overtime_start_time = Time.get_unix_time_from_system()
			notification_sound.play()
			progress_bar.value = 0
		PomoState.IDLE:
			pomodoro_timer.stop()
			timer_message.hide()
			progress_bar.value = 0
			#_time_to_display = timer_length

	current_state = new_state
	#print_state_conditions()


func print_state_conditions() -> void:
	print("-------------------")
	print("current round: ", Round.find_key(current_round))
	print("current PomoState: ", PomoState.find_key(current_state))
	print("prod PomoState: ", PomoState.find_key(productivity_state))
	print("-------------------")


func check_current_round() -> void:
	current_round = wrap(current_round, Round.FIRST, Round.FOURTH + 1)
	round_label.text = str(current_round) + '/4'


func determine_break_length_to_display() -> void:
	if productivity_state != PomoState.BREAK:
		return

	if current_round == Round.FOURTH:
		_time_to_display = long_break_length
	else:
		_time_to_display = short_break_length


func save() -> Dictionary:
	var save_dictionary := {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"current_round": current_round,
		"productivity_state": productivity_state,
	}
	return save_dictionary


func _on_pomodoro_timer_timeout() -> void:
	change_state(PomoState.OVERTIME)


func _on_start_button_pressed() -> void:
	match current_state:
		PomoState.OVERTIME:
			if productivity_state == PomoState.BREAK:
				change_state(PomoState.WORK)
			else:
				change_state(PomoState.BREAK)
		PomoState.IDLE:
			change_state(productivity_state)
		_:
			print("start button unavailable")


func _on_go_back_button_pressed() -> void:
	if current_state == PomoState.IDLE:
		if productivity_state == PomoState.BREAK:
			productivity_state = PomoState.WORK
			_time_to_display = work_round_length
		else:
			productivity_state = PomoState.BREAK
			current_round -= 1
			check_current_round()
			determine_break_length_to_display()
	else:
		change_state(PomoState.IDLE)
		if productivity_state == PomoState.BREAK:
			determine_break_length_to_display()
		else:
			_time_to_display = work_round_length

	check_current_round()


func _on_pause_button_pressed() -> void:
	match current_state:
		PomoState.IDLE, PomoState.OVERTIME:
			print("pause unavailable")
		PomoState.PAUSED:
			change_state(productivity_state)
		_:
			change_state(PomoState.PAUSED)


func _on_skip_button_pressed() -> void:
	match current_state:
		PomoState.IDLE:
			if productivity_state == PomoState.BREAK:
				productivity_state = PomoState.WORK
				_time_to_display = work_round_length
				current_round += 1
			else:
				productivity_state = PomoState.BREAK
				determine_break_length_to_display()
		PomoState.BREAK:
			current_round += 1
			productivity_state = PomoState.WORK
			_time_to_display = work_round_length
		PomoState.WORK:
			productivity_state = PomoState.BREAK
			determine_break_length_to_display()
		PomoState.OVERTIME:
			if productivity_state == PomoState.BREAK:
				productivity_state = PomoState.WORK
				_time_to_display = work_round_length
				current_round += 1
			else:
				productivity_state = PomoState.BREAK
				determine_break_length_to_display()
	change_state(PomoState.IDLE)

	check_current_round()


func _on_stop_button_pressed() -> void:
	productivity_state = PomoState.WORK
	current_round = Round.FIRST
	check_current_round()
	_time_to_display = work_round_length
	change_state(PomoState.IDLE)

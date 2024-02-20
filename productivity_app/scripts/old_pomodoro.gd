#extends TabBar
#
#
#enum State {
	#PAUSED,
	#WORK,
	#BREAK,
	#OVERTIME,
	#INACTIVE,
#}
#
#enum Round { FIRST, SECOND, THIRD, FOURTH }
#
#@export var pomodoro_timer : Timer
#@export var round_label : Label
#@export var pomodoro_time_remaining_label : Label
#@export var timer_message : Label
#@export var paused_message : Label
#@export var short_break_length : float = .07
#@export var long_break_length : float = .1
#@export var work_round_length : float = .05
#
#var timer_length : int
#var time_to_display : float
#var overtime_start_time : float
#var state : State
#var previous_state : State
#
#@onready var current_round : Round
#@onready var start_button : Button = %StartButton
#@onready var notification_sound : AudioStreamPlayer = %NotificationSound
#@onready var progress_bar : ProgressBar = $VBoxContainer/ProgressBar
#
#
#func _ready() -> void:
	#short_break_length *= 60
	#long_break_length *= 60
	#work_round_length *= 60
#
	#timer_length = work_round_length
#
	#change_state(State.INACTIVE)
#
#
#func _process(_delta: float) -> void:
	#if state == State.OVERTIME:
		#time_to_display = overtime_start_time - Time.get_unix_time_from_system()
	#else:
		#time_to_display = pomodoro_timer.time_left
#
	#pomodoro_time_remaining_label.text = get_formatted_time_from_seconds(ceili(time_to_display))
#
	#if not pomodoro_timer.is_stopped():
		#progress_bar.max_value = timer_length
		#progress_bar.value = pomodoro_timer.time_left
#
#
#func get_formatted_time_from_seconds(seconds : int) -> String:
	#var is_negative : bool = false
	#if seconds < 0:
		#seconds = abs(seconds)
		#is_negative = true
#
	#var hours : int = seconds / 3600
	#seconds -= hours * 3600
#
	#var minutes : int = seconds / 60
	#seconds -= minutes * 60
#
	#if is_negative:
		#return ("-" + "%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)
	#else:
		#return ("%02d" % hours) + ":" + str("%02d" % minutes) + ":" + ("%02d" % seconds)
#
#
#func change_state(new_state: State) -> void:
	#round_label.text = str(current_round + 1) + '/4'
#
	#match new_state:
		#State.PAUSED:
			#pomodoro_timer.paused = true
			#paused_message.show()
		#State.WORK:
			#if state != State.PAUSED:
				#timer_length = work_round_length
				#pomodoro_timer.start(timer_length)
				#timer_message.text = "Work"
				#timer_message.show()
			#else:
				#pomodoro_timer.paused = false
				#paused_message.hide()
		#State.BREAK:
			#if state != State.PAUSED:
				## Decide between short and long break
				#if current_round == Round.FOURTH:
					#timer_length = long_break_length
					#pomodoro_timer.start(long_break_length)
				#else:
					#timer_length = short_break_length
					#pomodoro_timer.start(short_break_length)
				#timer_message.text = "Break"
				#timer_message.show()
			#else:
				#pomodoro_timer.paused = false
				#paused_message.hide()
		#State.OVERTIME:
			#pass
		#State.INACTIVE:
			#paused_message.hide()
	#previous_state = state
	#state = new_state
#
	##for item in State:
		##if State.find_key(state):
			##print(State.find_key(state))
#
#
#func _on_start_button_pressed() -> void:
	#if state == State.WORK:
		#change_state(State.PAUSED)
	#elif state == State.OVERTIME and previous_state == State.WORK:
		#change_state(State.BREAK)
	##elif state == State.INACTIVE and previous_state == State.BREAK:
		##change_state(State.BREAK)
	#else:
		#change_state(State.WORK)
#
#
#func _on_go_back_button_pressed() -> void:
	#pomodoro_timer.stop()
	#progress_bar.value = progress_bar.max_value
	#if state == State.OVERTIME:
		#change_state(previous_state)
	#else:
		#change_state(State.INACTIVE)
#
#
#func _on_pomodoro_timer_timeout() -> void:
	#if state == State.BREAK:
		#if current_round == Round.FOURTH:
			#current_round = Round.FIRST
		#else:
			#current_round += 1;
		#timer_message.text = "Get back to it"
	#else:
		#change_state(State.BREAK)
		#timer_message.text = "Take a break"
#
	#timer_message.show()
#
	#overtime_start_time = Time.get_unix_time_from_system()
	#change_state(State.OVERTIME)
	#notification_sound.play()
#
#
#func _on_stop_button_pressed() -> void:
	#current_round = Round.FIRST
	#pomodoro_timer.stop()
	#timer_message.text = ""
	#change_state(State.INACTIVE)
#
#
#func _on_pause_button_pressed() -> void:
	#match state:
		#State.WORK:
			#change_state(State.PAUSED)
		#State.BREAK:
			#change_state(State.PAUSED)
		#State.PAUSED when previous_state == State.WORK:
			#change_state(State.WORK)
		#State.PAUSED when previous_state == State.BREAK:
			#change_state(State.BREAK)
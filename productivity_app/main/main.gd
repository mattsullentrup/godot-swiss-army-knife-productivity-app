extends Node


var _wants_to_quit := false

@onready var _save_system: SaveSystem = $SaveSystem
@onready var _pink_noise: AudioStreamPlayer = %PinkNoise
@onready var _pomodoro_timer: PanelContainer = %PomodoroTimerContainer


func _ready() -> void:
	_pomodoro_timer.get_node("StateMachine").notification_sound = %NotificationSound
	Util.setup_child_buttons_focus(self)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit") and not _wants_to_quit:
		_quit()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST and not _wants_to_quit:
		_quit()


func _quit() -> void:
	_wants_to_quit = true
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

	if _pink_noise.is_inside_tree():
		await _pink_noise.tree_exited

	if not _save_system.is_game_saved:
		await _save_system.game_saved

	get_tree().quit.call_deferred()

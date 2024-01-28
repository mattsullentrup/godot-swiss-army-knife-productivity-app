extends TabBar


enum Round {
	FIRST = 1,
	SECOND = 2,
	THIRD = 3,
	FOURTH = 4,
}

@export var pomodoro_label: Label

var current_round: int


func _ready() -> void:
	pomodoro_label.text = str(Round.FIRST) + '/4'

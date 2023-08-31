extends Node2D


# Score labels node references.
onready var score_left : Label = $ScoreLeft
onready var score_right : Label = $ScoreRight
# Timer node reference.
onready var timer : Timer = $Timer
# Player node references.
onready var player_one : Node2D = $Player1
onready var player_two : Node2D = $Player2
# Ball node reference.
onready var ball : Node2D = $Ball


# Called when the object is initialized in memory.
func _init() -> void:
	set_process(false)


# Called when the node and its children have entered the scene tree.
func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_end")
	set_process(true)


# Called every frame.
# @param delta Frame time.
func _process(_delta) -> void:
	var ball_position : Vector2 = ball.get_position()
	var players_size : float = player_one.get_y_size()
	if ball_position.x > Controls.get_viewport_size().x * 0.5:
		var player_two_position : Vector2 = player_two.get_position()
		if (ball_position.x >= player_two_position.x and 
			!(ball_position.x > player_two_position.x + ball.get_size().x) and
			ball_position.y < player_two_position.y + players_size and 
			ball_position.y > player_two_position.y - players_size):
			ball.influence_direction(Vector2(-1.1, ball_position.y - player_two_position.y))
		elif ball_position.x >= Controls.get_viewport_size().x:
			set_process(false)
			ball.set_process(false)
			score_left.set_text(str(score_left.get_text().to_int() + 1))
			timer.start()
	else:
		var player_one_position : Vector2 = player_one.get_position()
		if (ball_position.x <= player_one_position.x and
			!(ball_position.x < player_one_position.x - ball.get_size().x) and
			ball_position.y < player_one_position.y + players_size and 
			ball_position.y > player_one_position.y - players_size):
			ball.influence_direction(Vector2(-1.1, ball_position.y - player_one_position.y))
		elif ball_position.x <= 0:
			set_process(false)
			ball.set_process(false)
			score_right.set_text(str(score_right.get_text().to_int() + 1))
			timer.start()


# Called when the timer ends.
# Resets ball position.
func _on_timer_end() -> void:
	ball._reset_ball()
	set_process(true)

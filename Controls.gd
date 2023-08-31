extends Node


# Signal used for player emitting input.
signal signal_player_input(_params)


# Called every frame.
# @param delta Frame time.
func _process(delta : float) -> void:
	# Process players input.
	if Input.is_action_pressed("player1_up"):
		emit_signal("signal_player_input", {"Player" : 0, "Direction" : -1, "Delta" : delta})
	elif Input.is_action_pressed("player1_down"):
		emit_signal("signal_player_input", {"Player" : 0, "Direction" : 1, "Delta" : delta})
	if Input.is_action_pressed("player2_up"):
		emit_signal("signal_player_input", {"Player" : 1, "Direction" : -1, "Delta" : delta})
	elif Input.is_action_pressed("player2_down"):
		emit_signal("signal_player_input", {"Player" : 1, "Direction" : 1, "Delta" : delta})


# Returns the viewport size.
# @return Vector2 Viewport size.
func get_viewport_size() -> Vector2:
	var viewport : Viewport = get_viewport()
	var viewport_size : Vector2 = Vector2.ZERO
	if viewport != null:
		viewport_size = viewport.get_size()
	return viewport_size

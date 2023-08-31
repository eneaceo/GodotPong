extends Node2D


# Reference to sprite node.
onready var sprite : ColorRect = $Sprite

# Selection of player.
export(int, "Player One", "Player Two") var player : int = 0
# Movement speed.
export(float) var speed : float = 100.0


# Called when the node and its children have entered the scene tree.
func _ready() -> void:
	Controls.connect("signal_player_input", self, "_on_signal_player_input")


# Called every time a player input is detected.
# @param _params Signal parameters.
func _on_signal_player_input(_params : Dictionary) -> void:
	if _params.get("Player", -1) == player:
		var current_position : Vector2 = get_position()
		var new_position_y : float = current_position.y + speed * _params.get("Direction", 0.0) * _params.get("Delta", 0.0)
		if new_position_y < Controls.get_viewport_size().y and new_position_y > 0:
			set_position(Vector2(current_position.x, new_position_y))


# Returns player half sprite size.
# @return float Sprite size on Y.
func get_y_size() -> float:
	return sprite.get_size().y * 0.5

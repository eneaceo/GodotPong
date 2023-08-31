extends Node2D


# Reference to sprite node.
onready var sprite : ColorRect = $Sprite

# Direction and speed of the ball.
var m_direction : Vector2 = Vector2.ZERO


# Called when the object is initialized in memory.
func _init() -> void:
	set_process(false)


# Called when the node and its children have entered the scene tree.
func _ready() -> void:
	randomize()
	_reset_ball()


# Called every frame.
# @param delta Frame time.
func _process(delta : float) -> void:
	var new_position : Vector2 = get_position() + m_direction * delta
	if new_position.y <= 0 or new_position.y >= Controls.get_viewport_size().y:
		m_direction.y *= -1
	set_position(get_position() + m_direction * delta)


# Resets ball position to starting one.
func _reset_ball() -> void:
	set_process(false)
	set_position(Controls.get_viewport_size() * 0.5)
	m_direction = Vector2( -100 if randi() % 2 else 100, 0)
	set_process(true)


# Influences the direction the ball is moving.
# @param direction_influence Vector of influence.
func influence_direction(direction_influence : Vector2) -> void:
	m_direction.x *= direction_influence.x
	m_direction.y += direction_influence.y


# Returns ball half sprite size.
# @return Vector2 Sprite size.
func get_size() -> Vector2:
	return sprite.get_size() * 0.5

extends Node2D

var spawn_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_player_spawn_position(position : Vector2) -> void:
	spawn_position = position

func get_player_spawn_position() -> Vector2:
	return spawn_position

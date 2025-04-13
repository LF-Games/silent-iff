extends Area2D

@export var path_to_next_level : String
@export var spawn_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not path_to_next_level:
		print("Path to level missing")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		LevelManager.set_player_spawn_position(spawn_position)
		get_tree().change_scene_to_file.call_deferred(path_to_next_level)

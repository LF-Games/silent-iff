extends Area2D

@export var path_to_next_level : String				# Path para o .tscn do level a ser carregado
@export var spawn_position : Vector2				# Posição que o player ira iniciar no level carregado

func _ready() -> void:
	if not path_to_next_level:
		print("Path to level missing")
	pass # Replace with function body.

# Quando player entra no collider, carrega o level indicado
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		LevelManager.set_player_spawn_position(spawn_position)
		get_tree().change_scene_to_file.call_deferred(path_to_next_level)

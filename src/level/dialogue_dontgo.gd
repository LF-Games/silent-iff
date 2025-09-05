extends Area2D

@export var default_timeline: String				# 
@export var posx: float
@export var posy: float


func _get_timeline() -> String:
	return default_timeline

# Quando player entra no collider, começa o dialogo
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Dialogic.start(_get_timeline())

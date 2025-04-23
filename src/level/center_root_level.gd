extends Node2D

func _ready() -> void:
	# pra evitar problemas com a camera o level root deve estar sempre centralizado
	position = Vector2(0,0)

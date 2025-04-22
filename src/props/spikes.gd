extends AnimatedSprite2D

# Ativar a colisão quando os espinhos estiverem acionados
func close() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	play("closed")

# Desativar a colisão quando os espinhos estiverem retraídos
func open() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	play("open")

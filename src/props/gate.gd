extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(animation_finished)


# Animação abrindo o portão
func gate_opening()->void:
	if LevelManager.get_level_state_variable("college_gate_access"):
		$AnimatedSprite2D.play("opening")


# Portão aberto
func gate_opened()->void:
	$AnimatedSprite2D.play("open")
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)


# Animação fechando o portão
func gate_closing()->void:
	if LevelManager.get_level_state_variable("college_gate_access"):
		$AnimatedSprite2D.play("closing")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)


# Portão fechado
func gate_closed()->void:
	$AnimatedSprite2D.play("closed")


# Chamada quando uma animação termina
func animation_finished()->void:
	if $AnimatedSprite2D.get_animation() == "closing":
		gate_closed()
	elif $AnimatedSprite2D.get_animation() == "opening":
		gate_opened()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		gate_opening()
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		gate_closing()
	pass # Replace with function body.

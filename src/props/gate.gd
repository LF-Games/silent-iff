extends Area2D

var access_granted : bool : set = set_access_granted		# Controla se ao player pode abrir o portao


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	set_access_granted(true)

	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(animation_finished)

	pass # Replace with function body.


# Setter para accesso do player
func set_access_granted(val:bool)->void:
	access_granted = val


# Animação abrindo o portão
func gate_opening()->void:
	if access_granted:
		$AnimatedSprite2D.play("opening")


# Portão aberto
func gate_opened()->void:
	$AnimatedSprite2D.play("open")
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)


# Animação fechando o portão
func gate_closing()->void:
	if access_granted:
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

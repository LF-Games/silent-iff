extends Area2D
class_name MapGate

signal opened

@onready var anim := $AnimatedSprite2D as AnimatedSprite2D
@onready var collision_shape := $StaticBody2D/CollisionShape2D as CollisionShape2D


# Animação abrindo o portão
func open_gate() -> void:
	anim.play("opening")
	await anim.animation_finished
	anim.play("open")
	collision_shape.set_deferred("disabled", true)
	opened.emit()


# Animação fechando o portão
func close_gate() -> void:
	anim.play("closing")
	await anim.animation_finished
	anim.play("closed")
	collision_shape.set_deferred("disabled", false)


# func _on_body_entered(body: Node2D) -> void:
# 	if body is Player:
# 		open_gate()
# 	pass # Replace with function body.


# func _on_body_exited(body: Node2D) -> void:
# 	if body is Player:
# 		close_gate()
# 	pass # Replace with function body.

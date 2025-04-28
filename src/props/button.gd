extends Area2D

signal Button_Pressed
signal Button_Unpressed

var always_pressed : bool
var pressing_bodies : Array						# Lista de nodes colidindo com o botão

func _ready() -> void:
	# Quando always_pressed for true, o botão não vai interagir com o player
	# Vai estar sempre ativado
	always_pressed = LevelManager.get_level_state_variable("button_pressed")
	if always_pressed:
		Button_Pressed.emit();
		$AnimatedSprite2D.play("down")
	else:
		Button_Unpressed.emit();
		$AnimatedSprite2D.play("up")

# Monitora quando um node que pode interagir com o botão entrar no seu collider
# Atualiza a lista de nodes colidindo com o botão
func _on_body_entered(body: Node2D) -> void:
	if !always_pressed:
		if body is Player or body.is_in_group("pushable"):
			pressing_bodies.append(body.name)
			if pressing_bodies.size() == 1:
				$AnimatedSprite2D.play("down")
				Button_Pressed.emit()

# Monitora quando um node que pode interagir com o botão sair do seu collider
# Atualiza a lista de nodes colidindo com o botão
func _on_body_exited(body: Node2D) -> void:
	if !always_pressed:
		if body is Player or body.is_in_group("pushable"):
			pressing_bodies.erase(body.name)
			if pressing_bodies.size() == 0:
				$AnimatedSprite2D.play("up")
				Button_Unpressed.emit()

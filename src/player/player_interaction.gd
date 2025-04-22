extends Node2D

var current_interacting : Node2D 				# Armazena o node que o player está interagindo atualmente

func _ready() -> void:
	pass # Replace with function body.

# Quando o botão de ação for pressionado e houver um node armazenado em current_interacting
# Chama a função de interação do node
func action_pressed()->void:
	if current_interacting:
		current_interacting.interact()

# Se for possível interagir com o node que entrou no collider do player
# Armazena esse node em current_interacting
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		current_interacting = body

# Deleta a referência ao node quando ele sai da área do collider do player
func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		if current_interacting == body:
			current_interacting = null

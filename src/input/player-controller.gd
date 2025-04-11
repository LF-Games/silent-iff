extends Node

# Referencia para o node player
@onready var player : Node = $".."

# Define qual quem tem o controle do jogador
enum States {
	GAME_CONTROL,
	PLAYER_CONTROL
}

var control_state : States


func _ready() -> void:
	# for test only
	control_state = States.PLAYER_CONTROL
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if control_state == States.PLAYER_CONTROL:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		player.move(direction)
		
	elif control_state == States.GAME_CONTROL:
		pass

# Controle do personagem é do jogador
func control_to_player():
	control_state = States.PLAYER_CONTROL

# Controle do personagem é do jogo
func control_to_game():
	control_state = States.GAME_CONTROL

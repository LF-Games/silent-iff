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

func _process(delta: float) -> void:
	if control_state == States.PLAYER_CONTROL:
		var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		player.move(direction)
		
		if Input.is_action_just_pressed("action"):
			$"../Interaction".action_pressed()
		
	elif control_state == States.GAME_CONTROL:
		player.move(Vector2(0,0))
		if Input.is_action_just_pressed("action"):
			if LevelManager:
				LevelManager.action_pressed()
		pass

# Controle do personagem é do jogador
func control_to_player() -> void:
	control_state = States.PLAYER_CONTROL

# Controle do personagem é do jogo
func control_to_game() -> void:
	control_state = States.GAME_CONTROL

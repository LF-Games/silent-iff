extends Node2D

var spawn_position: Vector2 # Posição de spawn do player
var player_controller: Node # Referência para o node player_controller (Input do jogo)
var level_states: Dictionary # Armazenar estados com permanecia (Solução Temporária)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_level_state_variable("button_pressed", false)
	set_level_state_variable("barrel_exploded", false)
	set_level_state_variable("college_gate_access", false)
	Dialogic.timeline_started.connect(control_to_system)
	Dialogic.timeline_ended.connect(control_to_player)
	

# ----- Solução Temporária -----
func set_level_state_variable(state_name, state_value) -> void:
	level_states[state_name] = state_value


# ----- Solução Temporária -----
func get_level_state_variable(state_name: String):
	return level_states[state_name]


# Definir onde o player irá iniciar quando mudar de level
func set_player_spawn_position(pos: Vector2) -> void:
	spawn_position = pos

# Retorna as coordenadas para posicionar o player no carregamento do mapa
func get_player_spawn_position() -> Vector2:
	return spawn_position


# Recebe o Node responsável por gerenciar as Inputs do player
func set_player_controller(pc: Node):
	player_controller = pc

# Passa o controle da input para o sistema
func control_to_system() -> void:
	if player_controller:
		player_controller.control_to_game()


# Passa o controle da input para o player
func control_to_player() -> void:
	if player_controller:
		player_controller.control_to_player()

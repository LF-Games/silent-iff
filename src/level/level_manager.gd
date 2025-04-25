extends Node2D

var spawn_position : Vector2 					# Posição de spawn do player
var player_controller : Node					# Referência para o node player_controller (Input do jogo)
var button_pressed : bool						# Gambiarra para o prop button
var barrel_exploded : bool						# Gambiarra para o prop barril

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_pressed = false
	barrel_exploded = false
	
# ----- GAMBIARRA -----
# Variável usada pelo prop button para definir o funcionamento do botão
# Idealmente precisaria de um child node para gerenciar todos estados do level
func set_button_pressed(val:bool) -> void:
	button_pressed = val

# Definir onde o player irá iniciar quando mudar de level
func set_player_spawn_position(pos : Vector2) -> void:
	spawn_position = pos

func get_player_spawn_position() -> Vector2:
	return spawn_position


# Recebe o Node responsável por gerenciar as Inputs do player
func set_player_controller(pc : Node):
	player_controller = pc

func control_to_system()->void:
	player_controller.control_to_game()

func control_to_player()->void:
	player_controller.control_to_player()

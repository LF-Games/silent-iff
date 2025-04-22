extends Node2D

var spawn_position : Vector2 					# Posição de spawn do player
var canvas_visible : bool						# Visibilidade do canvas UI
var player_controller : Node					# Referência para o node player_controller (Input do jogo)
var button_pressed : bool						# Gambiarra para o prop button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_visible = false
	button_pressed = false

	$Dialogue/CanvasLayer.visible = false
	
	pass # Replace with function body.

# Definir onde o player irá iniciar quando mudar de level
func set_player_spawn_position(position : Vector2) -> void:
	spawn_position = position

func get_player_spawn_position() -> Vector2:
	return spawn_position

# ----- GAMBIARRA -----
# Variável usada pelo prop button para definir o funcionamento do botão
# Idealmente precisaria de um child node para gerenciar todos estados do level
func set_button_pressed(val:bool) -> void:
	button_pressed = val

# Alterna o estado do Canvas (On e Off)
func toggle_dialogue_canvas():
	canvas_visible = !canvas_visible
	$Dialogue/CanvasLayer.visible = canvas_visible

# Abre o Canvas de diálogo e retira o controle do jogador
func dialogue_canvas_on()->void:
	canvas_visible = true
	$Dialogue/CanvasLayer.visible = canvas_visible
	player_controller.control_to_game()

# Envia para o Cavas o texto e imagem a serem mostrados
func set_dialogue_text(text:String, image:CompressedTexture2D)->void:
	$Dialogue/CanvasLayer/Box/Avatar.texture = image
	$Dialogue/CanvasLayer/Text.text = text

# Recebe o Node responsável por gerenciar as Inputs do player
func set_player_controller(pc : Node):
	player_controller = pc

# Chamada de ação quando o botão de Input é pressionado e o controle é do Sistema
func action_pressed():
	toggle_dialogue_canvas()
	player_controller.control_to_player()
	pass

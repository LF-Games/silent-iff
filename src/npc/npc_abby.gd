extends StaticBody2D
class_name NPC

@export var dialogue_image : CompressedTexture2D			# Imagem que será mostrada na UI de diálogo
@export var dialogue_path : String							# Path para o .json que contém os diálogos do personagem
@export var dialogue_section : String						# key do diálogo referente ao level atual
var dialogue_json : Dictionary								# Armazena todo o diálogo na forma de um dicionário

var last_time : int											# Tempo em que houve última mudança de animação

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Inicializa estados do NPC
	last_time = 0
	$AnimatedSprite2D.play("reading")
	
	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(_flip_finished)

	# Busca o arquivo que contém os diálogos
	var json_text := FileAccess.get_file_as_string(dialogue_path)
	dialogue_json = JSON.parse_string(json_text)

func _process(delta: float) -> void:
	
	# A cada 1 segundo o NPC tem uma chance de 25% de mudar a animação 
	# Muda para a animação de flip_page
	if (Time.get_ticks_msec()/1000) > last_time:
		last_time = (Time.get_ticks_msec()/1000)
		var chance = randi_range(0,100)
		if chance < 25:
			$AnimatedSprite2D.play("flip_page")
			
# Quando a animação flip_page termina, o NPC retorna para reading
func _flip_finished() -> void:
	if $AnimatedSprite2D.get_animation() == "flip_page":
		$AnimatedSprite2D.play("reading")
		last_time += 2

# Função chamada pelo player para interação com o NPC
func interact()->void:
	var dialogue_quant = dialogue_json[dialogue_section]['speaking_to_player'].size()
	var random_dialogue : String = dialogue_json[dialogue_section]['speaking_to_player'][randi_range(0, (dialogue_quant-1))]
	speak(random_dialogue)
	LevelManager.dialogue_canvas_on()

# NPC envia o diálogo para ser exibido na UI
func speak(text:String)->void:
	LevelManager.set_dialogue_text(text, dialogue_image)

extends StaticBody2D
class_name NPC


enum NPC_Name { ABBY, BOUNCER }
const state_names := ["ABBY", "BOUNCER"]

@export var npc : NPC_Name									# Seleciona qual NPC será utilizado
var dialogue_json : Dictionary								# Armazena todo o diálogo na forma de um dicionário

var last_time : int											# Tempo em que houve última mudança de animação

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Inicializa estados do NPC
	last_time = 0
	$AnimatedSprite2D.play("reading")
	
	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(_flip_finished)

	# Conecta com o signal do Dialogic para saber quando o dialogo acabou
	Dialogic.signal_event.connect(dialogue_end_signal)


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
	match npc:
		NPC_Name.ABBY:
			speak("reading_under_light")
		NPC_Name.BOUNCER:
			speak("playing_on_phone")
			pass
	pass

# NPC envia o diálogo para ser exibido na UI
func speak(text:String)->void:
	Dialogic.start(text)
	LevelManager.control_to_system()

# Função conectada ao signal do diálogo
func dialogue_end_signal(npc_name: String)->void:
	if state_names.has(npc_name):
		LevelManager.control_to_player()

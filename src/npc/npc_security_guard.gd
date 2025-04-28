extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")

	# Conecta com o signal do Dialogic para saber quando o dialogo acabou
	Dialogic.signal_event.connect(dialogue_end_signal)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Função chamada pelo player para interação com o NPC
func interact()->void:
	speak("college_entrance_A")
	pass

# NPC envia o diálogo para ser exibido na UI
func speak(text:String)->void:
	Dialogic.start(text)
	LevelManager.control_to_system()

# Função conectada ao signal do diálogo
func dialogue_end_signal(dialogue_name: String)->void:
	if dialogue_name == "college_entrance_A":
		LevelManager.control_to_player()

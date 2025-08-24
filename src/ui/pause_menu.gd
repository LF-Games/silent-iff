extends Control

@export var top_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")	
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused == false:
		_pause()


func _retornar() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	Dialogic.Styles.get_layout_node().show()
	hide()


func _pause() -> void:
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	Dialogic.Styles.get_layout_node().hide()
	top_button.grab_focus()


func _on_retornar_pressed() -> void:
	_retornar()


func _on_sair_pressed() -> void:
	get_tree().quit()

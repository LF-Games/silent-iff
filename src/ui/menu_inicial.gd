extends Control

@export var path_to_scene_iniciar : String
@export var top_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_button.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_iniciar_pressed() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file.call_deferred(path_to_scene_iniciar)


func _on_sair_pressed() -> void:
	get_tree().quit();

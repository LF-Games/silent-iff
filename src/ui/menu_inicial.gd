extends Control

@export var path_to_scene_iniciar : String
@export var top_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_button.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_iniciar_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(path_to_scene_iniciar)


func _on_sair_pressed() -> void:
	get_tree().quit();

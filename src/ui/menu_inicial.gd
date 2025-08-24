extends Control

@export var path_to_scene_iniciar : String
@export var top_button : Button
var _input_enabled : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_input_enabled = false;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_iniciar_pressed() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if _input_enabled:
		get_tree().change_scene_to_file.call_deferred(path_to_scene_iniciar)


func _on_sair_pressed() -> void:
	if _input_enabled:
		get_tree().quit();


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		top_button.grab_focus()
		_input_enabled = true

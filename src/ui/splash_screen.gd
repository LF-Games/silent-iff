extends Control

@export var path_to_menu : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("fade_out")
	if anim_name == "fade_out":
		get_tree().change_scene_to_file.call_deferred(path_to_menu)

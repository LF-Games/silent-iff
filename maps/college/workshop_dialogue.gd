extends Node

@export var path_to_next_scene: String
@export var transition_delay := 1

func _process(delta: float) -> void:
	if Dialogic.start("robomeet"):
		await Dialogic.timeline_ended
		await get_tree().create_timer(transition_delay).timeout
		get_tree().change_scene_to_file.call_deferred(path_to_next_scene)

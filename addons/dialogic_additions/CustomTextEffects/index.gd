@tool
extends DialogicIndexer

func _get_subsystems() -> Array:
	return [{'name':'CustomTextEffects', 'script':this_folder.path_join('subsystem_custom_text_effects.gd')}]


func _get_text_modifiers() -> Array[Dictionary]:
		return [{
			"subsystem":"CustomTextEffects",
			"method":"apply_modifiers", 
			"mode": -1
		}]
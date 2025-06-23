@tool
extends DialogicIndexer

func _get_events() -> Array:
	return [this_folder.path_join('event_action_choices.gd')]

func _get_subsystems() -> Array:
	return [{'name':'ActionChoices', 'script':this_folder.path_join('subsystem_action_choices.gd')}]
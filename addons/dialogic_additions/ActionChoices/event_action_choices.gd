@tool
extends DialogicEvent
class_name DialogicActionChoicesEvent

## A choice event that requires the player to play an action minigame to determine the outcome.
## Needs to go after a text event, and must be added in pairs with type ambition and modesty

### Settings
## The text that is displayed on the choice button.
var text := ""
var choice_type: ActionChoices.ActionChoiceType = ActionChoices.ActionChoiceType.AMBITION
## A dictionary that can be filled with arbitrary information
## This can then be interpreted by a custom choice layer
var extra_data := {}


#endregion

#region EXECUTION
################################################################################

func _execute() -> void:
	if dialogic.ActionChoices.is_question(dialogic.current_event_idx):
		dialogic.Text.update_dialog_text('')
		dialogic.ActionChoices.show_current_question(false)
		dialogic.current_state = dialogic.States.AWAITING_CHOICE

#endregion


#region INITIALIZE
################################################################################

func _init() -> void:
	event_name = "Action Choice"
	set_default_color('Color3')
	event_category = "Flow"
	event_sorting_index = 0
	can_contain_events = true
	wants_to_group = true


# # return a control node that should show on the END BRANCH node
# func get_end_branch_control() -> Control:
# 	return load(get_script().resource_path.get_base_dir().path_join('ui_choice_end.tscn')).instantiate()
#endregion


#region SAVING/LOADING
################################################################################

func get_shortcode() -> String:
	return "action_choices"


func get_shortcode_parameters() -> Dictionary:
	return {
		"text": {"property": "text", "default": ""},
		"choice_type": {"property": "choice_type", "default": ActionChoices.ActionChoiceType.AMBITION}
		}

#endregion


#region TRANSLATIONS
################################################################################

func _get_translatable_properties() -> Array:
	return ['text']


func _get_property_original_translation(property: String) -> String:
	match property:
		'text':
			return text
	return ''
#endregion


#region EDITOR REPRESENTATION
################################################################################

func build_event_editor() -> void:
	add_header_edit("text", ValueType.SINGLELINE_TEXT, {'autofocus': true})
	add_header_edit("choice_type", ValueType.FIXED_OPTIONS, {'left_text': "Type: ", 'options': [
		{
			'label': "Ambition",
			'value': ActionChoices.ActionChoiceType.AMBITION,
		},
		{
			'label': "Modesty",
			'value': ActionChoices.ActionChoiceType.MODESTY,
		},
	]})
	add_body_edit("extra_data", ValueType.DICTIONARY, {"left_text": "Extra Data:"})

#endregion

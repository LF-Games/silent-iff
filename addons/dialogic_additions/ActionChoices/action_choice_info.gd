extends RefCounted
class_name ActionChoiceInfo

var event_index: int
var text: String
var choice_type: DialogicActionChoicesEvent.ActionChoiceType
var extra_data: Dictionary

func _init(p_event_index: int, p_text: String, p_choice_type: DialogicActionChoicesEvent.ActionChoiceType, p_extra_data := {}):
	event_index = p_event_index
	text = p_text
	choice_type = p_choice_type
	extra_data = p_extra_data

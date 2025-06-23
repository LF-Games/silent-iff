extends Node
class_name ActionChoices
## Classe com funções utilitárias a respeito da mecânica de escolhas

enum ActionChoiceType {AMBITION, MODESTY}

const AMBITION_COUNTER_KEY := "action_choices_ambition_counter"
const MODESTY_COUNTER_KEY := "action_choices_modesty_counter"


static func register_choice(type: ActionChoiceType):
	var key = AMBITION_COUNTER_KEY if type == ActionChoiceType.AMBITION else MODESTY_COUNTER_KEY
	var global_state = Engine.get_main_loop().root.get_node("GlobalState")
	if global_state:
		global_state.increment_counter(key)

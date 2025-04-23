extends DialogicSubsystem

## This subsystem creates text modifiers for easier reusable BBCode text effects. 


#region STATE
####################################################################################################

func clear_game_state(clear_flag:=Dialogic.ClearFlags.FULL_CLEAR) -> void:
	pass

func load_game_state(load_flag:=LoadFlags.FULL_LOAD) -> void:
	pass

#endregion


#region MAIN METHODS
####################################################################################################

func _wave_test(text:String) -> String:
	return "[wave] %s [/wave]" % text

var modifiers: Array[Callable] = [
	_wave_test
]

func apply_modifiers(text: String) -> String:
	for modifier in modifiers:
		text = modifier.call(text)
	return text		



#endregion

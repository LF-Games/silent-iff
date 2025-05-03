extends Node
## Classe responsavel por manter registros de estado ao longo do jogo.
##
## Utilize set_flag(key) e get_flag(key) para registrar/acessar dados booleanos.
## Utilize increment_counter(key) e get_counter(key) para incrementar/acessar contadores.
## Cada "key" deve ser salva como uma variavel const no script que faz uso desses dados. Exemplo:
## const DIALOGUE_STARTED_KEY = "school_npc_has_started_dialogue"


var _flags: Dictionary[StringName, bool] = {}
var _counters: Dictionary[StringName, int] = {}


func set_flag(key: StringName, value := true) -> bool:
	_flags[key] = value
	return value


func get_flag(key: StringName) -> bool:
	return _flags[key]


func increment_counter(key: StringName, value := 1) -> int:
	if not _counters.has(key):
		_counters[key] = value
	else:
		_counters[key] += value
	return _counters[key]


func get_counter(key: StringName) -> int:
	if not _counters.has(key):
		return 0
	return _counters[key]
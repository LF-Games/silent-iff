extends Node

const INTRO_DIALOGUE_KEY = "entrance_intro_dialogue_played"

@export var gate: MapGate
@export var upperclassman_spawn_pos := Vector2(-32, 79)
@export var npc_parent: Node2D

@onready var upperclassman_npc := load("res://entities/characters/npc_upperclassman.tscn") as PackedScene

var upperclassman_instance: GameCharacter

func _ready():
	if !GlobalState.get_flag(INTRO_DIALOGUE_KEY):
		Dialogic.signal_event.connect(_on_dialogic_signal)
		Dialogic.start("intro")

		await Dialogic.timeline_ended
		GlobalState.set_flag(INTRO_DIALOGUE_KEY)


func _on_dialogic_signal(arg: String):
	if arg == "spawn_upperclassman":
		_spawn_upperclassman()
	elif arg == "open_gate":
		_open_gate()
	elif arg == "despawn_upperclassman":
		_despawn_upperclassman()


func _spawn_upperclassman():
	upperclassman_instance = upperclassman_npc.instantiate() as GameCharacter
	npc_parent.add_child(upperclassman_instance)
	upperclassman_instance.global_position = upperclassman_spawn_pos
	upperclassman_instance.set_facing_direction(GameCharacter.Direction.UP)


func _despawn_upperclassman():
	upperclassman_instance.queue_free()


func _open_gate():
	Dialogic.paused = true
	gate.open_gate()
	await gate.opened
	Dialogic.paused = false

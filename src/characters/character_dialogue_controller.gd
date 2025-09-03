extends Node
## Classe para movimentação de NPCs durante diálogos


func move_to(char_name: String, pos_x: float, pos_y: float):
	var pos := Vector2(pos_x, pos_y)
	
	var character := _get_character_by_name(char_name) as GameCharacter

	if !character:
		push_warning("NPC not found in the scene tree: %s" % char_name)
		return
	
	Dialogic.paused = true
	var distance := character.global_position.distance_to(pos)
	var direction := character.global_position.direction_to(pos)
	character.set_facing_direction_vector(direction)
	character.set_movement_state(GameCharacter.Movement.WALK)
	var tween := create_tween()
	tween.tween_property(character, "global_position", pos, distance / character.walk_speed)
	await tween.finished
	character.set_movement_state(GameCharacter.Movement.IDLE)
	Dialogic.paused = false

func delete(char_name: String): #apaga o personagem da cena
	var character := _get_character_by_name(char_name) as GameCharacter

	if !character:
		push_warning("NPC not found in the scene tree: %s" % char_name)
		return
		
	character.queue_free()

func look_at(char_name: String, direction_str: String):
	var character := _get_character_by_name(char_name) as GameCharacter

	if !character:
		push_warning("NPC not found in the scene tree: %s" % char_name)
		return
	
	character.set_facing_direction(_string_to_direction(direction_str))


func _get_character_by_name(char_name: String) -> GameCharacter:
	var scene_characters := get_tree().get_nodes_in_group(GameCharacter.GROUP_KEY)
	var found_index := scene_characters.find_custom(func(c: Node):
		return c.name.to_lower() == char_name.to_lower()
	)

	if found_index == -1:
		return null
	return scene_characters[found_index] as GameCharacter


func _string_to_direction(string: String) -> GameCharacter.Direction:
	var normalized := string.to_lower().strip_edges()

	if normalized == "left":
		return GameCharacter.Direction.LEFT
	elif normalized == "right":
		return GameCharacter.Direction.RIGHT
	elif normalized == "up":
		return GameCharacter.Direction.UP
	elif normalized == "down":
		return GameCharacter.Direction.DOWN
	
	push_warning(
		"[CharacterDialogueController] Facing direction could not be determined from this string: %s. Valid directions are \"left\", \"right\", \"up\" and \"down\""
		% string)
	
	return GameCharacter.Direction.DOWN
	

	

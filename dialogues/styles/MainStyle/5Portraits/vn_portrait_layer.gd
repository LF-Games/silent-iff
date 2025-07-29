@tool
extends DialogicLayoutLayer

## A layer that allows showing 5 portraits, like in a visual novel.

## The canvas layer that the portraits are on.
@export var portrait_size_mode: DialogicNode_PortraitContainer.SizeModes = DialogicNode_PortraitContainer.SizeModes.FIT_SCALE_HEIGHT

@export var faded_color := Color(0.6, 0.6, 0.6, 1)


func _apply_export_overrides() -> void:
	# apply portrait size
	for child: DialogicNode_PortraitContainer in %Portraits.get_children():
		child.size_mode = portrait_size_mode
		child.update_portrait_transforms()


func _ready() -> void:
	DialogicUtil.autoload().Text.speaker_updated.connect(_on_speaker_updated)


func _on_speaker_updated(current_speaker: DialogicCharacter):
	for character: DialogicCharacter in Dialogic.Portraits.get_joined_characters():
		var current_portrait = Dialogic.Portraits.get_character_portrait(character)
		var target_color := Color(1, 1, 1, 1) if (current_speaker == character) else faded_color

		var tween := get_tree().create_tween()
		tween.tween_property(current_portrait, "modulate", target_color, 0.1)
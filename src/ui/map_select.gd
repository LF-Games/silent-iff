extends ColorRect

@export var focus_button: BaseButton

func _ready() -> void:
	focus_button.grab_focus()

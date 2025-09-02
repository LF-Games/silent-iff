extends TextureButton

@export var path_to_level: String
@export var selection_color: Color


func _ready():
	pressed.connect(_on_pressed)
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)


func _on_pressed():
	get_tree().change_scene_to_file.call_deferred(path_to_level)


func _on_focus_entered():
	modulate = selection_color


func _on_focus_exited():
	modulate = Color.WHITE

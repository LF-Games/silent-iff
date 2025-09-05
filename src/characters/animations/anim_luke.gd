extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Dialogic.VAR.book == 0:
		pass
	if Dialogic.VAR.book == 1:
		play("book flying")
		
	
func _on_animation_finished(anim_name: StringName) -> void:
	play("bookhover")# Replace with function body.

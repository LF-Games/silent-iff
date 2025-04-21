extends Node2D

var current_interacting : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func action_pressed()->void:
	if current_interacting:
		current_interacting.interact()
		LevelManager.dialogue_canvas_on()
	

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		current_interacting = body


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		if current_interacting == body:
			current_interacting = null

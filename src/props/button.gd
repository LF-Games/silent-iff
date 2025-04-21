extends Area2D

signal Button_Pressed
signal Button_Unpressed

var always_pressed : bool
var pressing_bodies : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	always_pressed = LevelManager.button_pressed
	if always_pressed:
		Button_Pressed.emit();
		$AnimatedSprite2D.play("down")
	else:
		Button_Unpressed.emit();
		$AnimatedSprite2D.play("up")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if always_pressed:
		$AnimatedSprite2D.play("down")

	pass


func _on_body_entered(body: Node2D) -> void:
	if !always_pressed:
		if body is Player or body.is_in_group("pushable"):
			pressing_bodies.append(body.name)
			if pressing_bodies.size() == 1:
				$AnimatedSprite2D.play("down")
				Button_Pressed.emit()


func _on_body_exited(body: Node2D) -> void:
	if !always_pressed:
		if body is Player or body.is_in_group("pushable"):
			pressing_bodies.erase(body.name)
			if pressing_bodies.size() == 0:
				$AnimatedSprite2D.play("up")
				Button_Unpressed.emit()

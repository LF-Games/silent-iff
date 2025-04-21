extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("up")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player or body.is_in_group("pushable"):
		$AnimatedSprite2D.play("down")


func _on_body_exited(body: Node2D) -> void:
	if body is Player or body.is_in_group("pushable"):
		$AnimatedSprite2D.play("up")

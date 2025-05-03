extends StaticBody2D

var last_time : int

func _ready() -> void:

	last_time = 0

	if LevelManager.get_level_state_variable("barrel_exploded"):
		barrel_exploded()
	else:
		$AnimatedSprite2D.play("base")

	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(moving_finished)

func _process(delta: float) -> void:

	# A cada 1 segundo o NPC tem uma chance de 50% de mudar a animação 
	# Muda para a animação de moving
	if !LevelManager.get_level_state_variable("barrel_exploded"):
		if (Time.get_ticks_msec()/1000) > last_time:
			last_time = (Time.get_ticks_msec()/1000)
			var chance = randi_range(0,100)
			if chance < 50:
				$AnimatedSprite2D.play("moving")


# Quando a animação moving termina, o barril retorna para base
func moving_finished() -> void:
	if $AnimatedSprite2D.get_animation() == "moving":
		$AnimatedSprite2D.play("base")
		last_time += 1 			# Adiciona 1 seg de espera até a próxima mudança
	elif $AnimatedSprite2D.get_animation() == "explosion":
		barrel_exploded()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and !LevelManager.get_level_state_variable("barrel_exploded"):
		$AnimatedSprite2D.play("explosion")
		$AudioStreamPlayer2D.play()
		LevelManager.barrel_exploded = true
		$CollisionShape2D.set_deferred("disabled", true)

func barrel_exploded()-> void:
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite2D.play("exploded")

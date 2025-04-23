extends StaticBody2D

var last_time : int

func _ready() -> void:

	last_time = 0

	if LevelManager.barrel_exploded:
		$AnimatedSprite2D.play("exploded")
	else:
		$AnimatedSprite2D.play("base")

	# Conecta com o signal de animação terminada
	$AnimatedSprite2D.animation_finished.connect(_moving_finished)

func _process(delta: float) -> void:

	# A cada 1 segundo o NPC tem uma chance de 50% de mudar a animação 
	# Muda para a animação de moving
	if !LevelManager.barrel_exploded:
		if (Time.get_ticks_msec()/1000) > last_time:
			last_time = (Time.get_ticks_msec()/1000)
			var chance = randi_range(0,100)
			if chance < 50:
				$AnimatedSprite2D.play("moving")


# Quando a animação moving termina, o barril retorna para base
func _moving_finished() -> void:
	if $AnimatedSprite2D.get_animation() == "moving":
		$AnimatedSprite2D.play("base")
		last_time += 1 			# Adiciona 1 seg de espera até a próxima mudança
	elif $AnimatedSprite2D.get_animation() == "explosion":
		$AnimatedSprite2D.play("exploded")
		LevelManager.barrel_exploded = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and !LevelManager.barrel_exploded:
		$AnimatedSprite2D.play("explosion")
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.set_deferred("disabled", true)
		LevelManager.barrel_exploded = true

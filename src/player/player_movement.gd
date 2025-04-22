extends CharacterBody2D
class_name Player

@onready var animacao : AnimatedSprite2D = $AnimatedSprite2D
@export var walk_speed : int = 50
@export var run_speed : int = 100

enum Direction {
	RIGHT, 
	LEFT, 
	FRONT, 
	BACK
}

enum Movement {
	IDLE,
	WALK,
	RUN
}

var facing_direction : Direction
var player_movement : Movement
var is_running : bool
const PUSH_FORCE : int = 300

func _ready() -> void:

	# Define a posição que o player ira iniciar o level
	var playerPosition : Vector2 = LevelManager.get_player_spawn_position()
	if playerPosition: 
		position = LevelManager.get_player_spawn_position()
	
	# Define estados padrões para as animações
	facing_direction = Direction.FRONT
	player_movement = Movement.IDLE
	is_running = false
	
	# Envia o player_controller para o Leve Manager
	if LevelManager:
		LevelManager.set_player_controller($Controller)


func _process(delta: float) -> void:	
	player_animation()	
	player_interaction_area()

func _physics_process(delta: float) -> void:
	push_block()

# Movimentação do player
func move(direction : Vector2) -> void:
	# Atualiza as variáveis de estado do player
	set_facing_direction(direction)
	set_player_movement(direction)
	
	# Movimenta o player
	velocity = direction*(run_speed if (player_movement == Movement.RUN) else walk_speed)
	move_and_slide()

# Atualiza o estado com o tipo de direção que o sprite irá mostrar
func set_facing_direction(direction: Vector2) -> void:
	if (direction.x > 0):
		facing_direction = Direction.RIGHT
	elif (direction.x < 0):
		facing_direction = Direction.LEFT
	elif (direction.y > 0):
		facing_direction = Direction.FRONT
	elif (direction.y < 0):
		facing_direction = Direction.BACK

# Atualiza o estado com o tipo de movimento que o sprite irá mostrar
func set_player_movement(direction: Vector2) -> void:
	if (direction.length() == 0):
		player_movement = Movement.IDLE
	else:
		if(is_running):
			player_movement = Movement.RUN
		else:
			player_movement = Movement.WALK

# Player andando ou correndo
func set_player_run(run_state:bool) -> void:
	is_running = run_state

# Atualiza as animações do player com base nos estados Direction e Movement
func player_animation() -> void:
	# Animação do player
	if (facing_direction == Direction.RIGHT):
		if(player_movement == Movement.IDLE):
			animacao.play("idle_right")
		if(player_movement == Movement.WALK):
			animacao.play("walk_right")
		if(player_movement == Movement.RUN):
			pass
	if (facing_direction == Direction.LEFT):
		if(player_movement == Movement.IDLE):
			animacao.play("idle_left")
		if(player_movement == Movement.WALK):
			animacao.play("walk_left")
		if(player_movement == Movement.RUN):
			pass
	if (facing_direction == Direction.FRONT):
		if(player_movement == Movement.IDLE):
			animacao.play("idle_front")
		if(player_movement == Movement.WALK):
			animacao.play("walk_front")
		if(player_movement == Movement.RUN):
			pass
	if (facing_direction == Direction.BACK):
		if(player_movement == Movement.IDLE):
			animacao.play("idle_back")
		if(player_movement == Movement.WALK):
			animacao.play("walk_back")
		if(player_movement == Movement.RUN):
			pass

# Interação com o objetos que podem ser empurrados
func push_block() -> void:
	var colliding : KinematicCollision2D = get_last_slide_collision()
	if colliding:
		var collinding_node = colliding.get_collider()
		if collinding_node.is_in_group("pushable") and player_movement != Movement.IDLE:
			var collision_normal: Vector2 = colliding.get_normal()
			var force_vector: Vector2
			if abs(collision_normal.x) > abs(collision_normal.y):
				force_vector = Vector2(1,0)*sign(collision_normal.x)*(-1)
			else:
				force_vector = Vector2(0,1)*sign(collision_normal.y)*(-1)
				
			collinding_node.apply_central_force(force_vector * PUSH_FORCE)

# Atualiza a posição do collider de interação do player com os ambiente
# Muda de acordo com a posição do jogador pra sempre estar na direção do movimento
func player_interaction_area()->void:
	if (facing_direction == Direction.RIGHT):
		$InteractionArea.position = Vector2(8,0)
	elif (facing_direction == Direction.LEFT):
		$InteractionArea.position = Vector2(-8,0)
	elif (facing_direction == Direction.FRONT):
		$InteractionArea.position = Vector2(0,5)
	elif (facing_direction == Direction.BACK):
		$InteractionArea.position = Vector2(0,-5)

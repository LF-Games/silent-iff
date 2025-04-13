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

func _ready() -> void:
	position = LevelManager.get_player_spawn_position()
	facing_direction = Direction.FRONT
	player_movement = Movement.IDLE
	is_running = false


func _process(delta: float) -> void:
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

func move(direction : Vector2) -> void:
	# Atualiza as variáveis de estado do player
	set_facing_direction(direction)
	set_player_movement(direction)
	
	# Movimenta o player
	velocity = direction*(run_speed if (player_movement == Movement.RUN) else walk_speed)
	move_and_slide()

func set_facing_direction(direction: Vector2) -> void:
	if (direction.x > 0):
		facing_direction = Direction.RIGHT
	elif (direction.x < 0):
		facing_direction = Direction.LEFT
	elif (direction.y > 0):
		facing_direction = Direction.FRONT
	elif (direction.y < 0):
		facing_direction = Direction.BACK

func set_player_movement(direction: Vector2) -> void:
	if (direction.length() == 0):
		player_movement = Movement.IDLE
	else:
		if(is_running):
			player_movement = Movement.RUN
		else:
			player_movement = Movement.WALK

func set_player_run(run_state:bool) -> void:
	is_running = run_state

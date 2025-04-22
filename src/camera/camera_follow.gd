extends Camera2D

const SMOOTHING_DURATION: = 0.2
const POSITION_DIVIDER:= 0.2

@export var level_boundaries : TileMapLayer
@export var target : Node2D

# Posição atual da camera
var current_position: Vector2

# Posição final da camera
var destination_position: Vector2

func _ready() -> void:
	# Se nenhum target foi definido, procura pelo player 
	if not target:
		target = get_parent().find_child("Player")

	# Se nenhum limite foi definido, procura pelo limite do level  
	if not level_boundaries:
		level_boundaries = get_parent().find_child("LevelBoundaries")
	
	
	# Define limites de scroll da camera
	set_camera_limits()
	
	# Inicia a camera no player
	position = target.position	
	current_position = position

func _process(delta: float) -> void:
	destination_position = target.position

	# Suavização do movimento feito de forma manual
	# Feito assim pra evitar jittering dos sprites
	current_position += Vector2(destination_position.x - current_position.x, destination_position.y - current_position.y) / SMOOTHING_DURATION * delta
	position = ((current_position*5).round())/5
	force_update_scroll()
	
	

func set_camera_limits() -> void:
	if not level_boundaries:
		return
	# retangulo que contém o mapa
	var rect_map : Rect2i = level_boundaries.get_used_rect()
	# tamanho de cada tile
	var tile_size : Vector2i = level_boundaries.tile_set.get_tile_size()
	# define limites da camera
	limit_left = rect_map.position.x * tile_size.x
	limit_top = rect_map.position.y * tile_size.y
	limit_right = (rect_map.position.x + rect_map.size.x) * tile_size.x
	limit_bottom = (rect_map.position.y + rect_map.size.y) * tile_size.y

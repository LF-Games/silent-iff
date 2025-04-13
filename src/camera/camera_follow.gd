extends Camera2D

@export var level_boundaries : TileMapLayer
@export var target : Node2D

func _ready() -> void:
	# Se nenhum target foi definido, procura pelo player no mesmo nível hierárquico
	if not target:
		target = get_parent().find_child("Player")
	
	# Define limites de scroll da camera
	set_camera_limits()

func _process(delta: float) -> void:
	position = target.position

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

extends Camera2D

@export var base_layer : TileMapLayer
@export var target : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Se nenhum target foi definido, procura pelo player no mesmo nível hierárquico
	if (target == null):
		target = get_parent().find_child("Player")
	
	# Define limites de scroll da camera
	set_camera_limits()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = target.position

func set_camera_limits():
	if not base_layer:
		return
	# retangulo que contém o mapa
	var rect_map : Rect2i = base_layer.get_used_rect()
	# tamanho de cada tile
	var tile_size : Vector2i = base_layer.tile_set.get_tile_size()
	# define limites da camera
	limit_left = rect_map.position.x * tile_size.x
	limit_top = rect_map.position.y * tile_size.y
	limit_right = (rect_map.position.x + rect_map.size.x) * tile_size.x
	limit_bottom = (rect_map.position.y + rect_map.size.y) * tile_size.y

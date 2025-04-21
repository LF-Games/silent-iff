extends AnimatedSprite2D

var light : PointLight2D
var multiplier : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("Candle")
	light = $PointLight2D
	multiplier = randf_range(2,5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#light.energy = cos( deg_to_rad(Time.get_unix_time_from_system()))
	light.energy = abs(cos(Time.get_unix_time_from_system()*multiplier))
	pass

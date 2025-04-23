extends AnimatedSprite2D

var light : PointLight2D
var multiplier : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("Candle")
	light = $PointLight2D
	# Define a velocidade com que a luz irá tremer
	multiplier = randf_range(2,5)

func _process(delta: float) -> void:
	# Efeito de tremer a luz para combinar com o sprite (fogo) 	
	light.energy = abs(cos(Time.get_unix_time_from_system()*multiplier))
	pass

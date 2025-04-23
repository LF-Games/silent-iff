# -----GAMBIARRA------
# Precisa fazer um node para monitorar as mudanças de estado do level  
extends Node2D

func _ready() -> void:
	LevelManager.set_button_pressed(true)
	pass # Replace with function body.

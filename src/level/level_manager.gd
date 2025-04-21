extends Node2D

var spawn_position : Vector2
var button_pressed : bool
var canvas_visible : bool
var player_controller : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_visible = false
	button_pressed = false

	$Dialogue/CanvasLayer.visible = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_player_spawn_position(position : Vector2) -> void:
	spawn_position = position

func get_player_spawn_position() -> Vector2:
	return spawn_position

func set_button_pressed(val:bool) -> void:
	button_pressed = val

func toggle_dialogue_canvas():
	canvas_visible = !canvas_visible
	$Dialogue/CanvasLayer.visible = canvas_visible

func dialogue_canvas_on()->void:
	canvas_visible = true
	$Dialogue/CanvasLayer.visible = canvas_visible
	player_controller.control_to_game()

func set_dialogue_text(text:String, image:CompressedTexture2D)->void:
	$Dialogue/CanvasLayer/Box/Avatar.texture = image
	$Dialogue/CanvasLayer/Text.text = text

func set_player_controller(pc : Node):
	player_controller = pc

func action_pressed():
	toggle_dialogue_canvas()
	player_controller.control_to_player()
	pass

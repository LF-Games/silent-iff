extends StaticBody2D
class_name NPC

@export var dialogue_image : CompressedTexture2D
@export var dialogue_path : String
@export var dialogue_section : String

var last_time : int
var dialogue_json : Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("reading")
	$AnimatedSprite2D.animation_finished.connect(_flip_finished)
	last_time = 0

	var json_text := FileAccess.get_file_as_string(dialogue_path)
	dialogue_json = JSON.parse_string(json_text)
	print(dialogue_json[dialogue_section]['speaking_to_player'][1])




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Time.get_ticks_msec()/1000) > last_time:
		last_time = (Time.get_ticks_msec()/1000)
		var chance = randi_range(0,100)
		if chance < 25:
			$AnimatedSprite2D.play("flip_page")
			

func _flip_finished() -> void:
	if $AnimatedSprite2D.get_animation() == "flip_page":
		$AnimatedSprite2D.play("reading")
		last_time += 2


func speak(text:String)->void:
	LevelManager.set_dialogue_text(text, dialogue_image)

func interact()->void:
	var dialogue_quant = dialogue_json[dialogue_section]['speaking_to_player'].size()
	var random_dialogue : String = dialogue_json[dialogue_section]['speaking_to_player'][randi_range(0, (dialogue_quant-1))]
	speak(random_dialogue)

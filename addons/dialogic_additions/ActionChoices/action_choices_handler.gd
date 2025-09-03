extends Control
class_name ActionChoicesHandler

signal choice_selected(choice: ActionChoiceInfo)

const GROUP_KEY := 'action_choices_handler'

@export var pointer: Control
@export var choice_bar: Control
@export var movement_cycle_duration := 0.5
@export var confirm_delay := 1.0
@export var ambition_label: RichTextLabel
@export var modesty_label: RichTextLabel
@export var input_lock_duration := 0.05
@export var textbox_texture: Control

var _active := false
var _tween: Tween
var _pointer_progress := 0.5
var _ambition_choice: ActionChoiceInfo
var _modesty_choice: ActionChoiceInfo


func _ready():
	add_to_group(GROUP_KEY)
	_disable_display()


func _process(_delta):
	if !_active:
		return
	
	if Input.is_action_just_pressed("action"):
		_tween.kill()
		_pick_choice()


func start_choice(ambition_choice: ActionChoiceInfo, modesty_choice: ActionChoiceInfo):
	ambition_label.text = ambition_choice.text
	_ambition_choice = ambition_choice
	modesty_label.text = modesty_choice.text
	_modesty_choice = modesty_choice

	_enable_display()
	_start_pointer_movement()
	await get_tree().create_timer(input_lock_duration).timeout
	_active = true


func clear():
	_disable_display()
	
	_active = false
	if _tween and _tween.is_running():
		_tween.kill()
	_pointer_progress = 0.5


func _start_pointer_movement():
	pointer.position.x = (choice_bar.size.x - pointer.size.x) / 2.0

	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)

	var progress_points := [0.0, 1.0]
	progress_points.shuffle()
	_tween.tween_method(_set_pointer_progress, _pointer_progress, progress_points[0], movement_cycle_duration / 2)
	await _tween.finished
	_tween = create_tween()
	_tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
	_tween.set_loops()
	_tween.tween_method(_set_pointer_progress, progress_points[0], progress_points[1], movement_cycle_duration)
	_tween.tween_method(_set_pointer_progress, progress_points[1], progress_points[0], movement_cycle_duration)


func _set_pointer_progress(value: float):
	_pointer_progress = value
	var left_x := 0.0
	var right_x := choice_bar.size.x - pointer.size.x
	pointer.position.x = lerp(left_x, right_x, _pointer_progress)


func _pick_choice():
	_active = false

	await get_tree().create_timer(confirm_delay).timeout

	if _pointer_progress <= 0.5:
		choice_selected.emit(_ambition_choice)
	else:
		choice_selected.emit(_modesty_choice)


func _enable_display():
	show()
	textbox_texture.hide()
	for node: Control in get_tree().get_nodes_in_group('dialogic_portrait_con_speaker'):
		node.hide()
	for node: Control in get_tree().get_nodes_in_group('dialogic_portrait_con_position'):
		node.hide()


func _disable_display():
	hide()
	textbox_texture.show()
	for node: Control in get_tree().get_nodes_in_group('dialogic_portrait_con_speaker'):
		node.show()
	for node: Control in get_tree().get_nodes_in_group('dialogic_portrait_con_position'):
		node.show()
